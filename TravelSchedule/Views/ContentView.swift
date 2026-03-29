//
//  ContentView.swift
//  TravelSchedule
//
//  Created by Svetlana on 2026/3/29.
//

import SwiftUI
import CoreData
import OpenAPIURLSession

struct ContentView: View {
    @Environment(\.managedObjectContext) private var viewContext
    
    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Item.timestamp, ascending: true)],
        animation: .default)
    private var items: FetchedResults<Item>
    
    var body: some View {
        NavigationView {
            
            Text("...")
            
        }.onAppear {
            Task {
                await testFetchNearestStations()
                await testFetchScheduleBetweenStations()
                await testFetchStationSchedule()
                await testFetchRouteStations()
                await testFetchNearestCity()
                await testFetchCarrierInfo()
                await testFetchStationsList()
                await testFetchCopyright()
            }
        }
    }
    
    
    func testFetchNearestStations() async {
        do {
            let service = makeService(NearestStationsService.self)
            print("Fetching stations...")
            
            let stations = try await service.getNearestStations(
                lat: 59.864177,
                lng: 30.319163,
                distance: 50
            )
            
            print("✅ Successfully fetched nearest stations: \(String(describing: stations.stations?.count))")
        } catch {
            print("❌ Error fetching nearest stations: \(error)")
        }
    }
    
    func testFetchScheduleBetweenStations() async {
        do {
            let service = makeService(ScheduleBetweenStationsService.self)
            print("Fetching schedule...")
            
            let schedule = try await service.getScheduleBetweenStations(
                from: "c213",
                to: "c146",
                date: getISO8601String())
            
            print("✅ Successfully fetched schedule btw stations: \(String(describing: schedule.segments?.count))")
        } catch {
            print("❌ Error fetching schedule btw stations: \(error)")
        }
    }
    
    
    func testFetchStationSchedule() async {
        do {
            let service = makeService(StationScheduleService.self)
            print("Fetching station schedule...")
            
            let schedule = try await service.getStationSchedule(
                station: "s9600213",
                date: getISO8601String())
            
            print("✅ Successfully fetched station schedule: \(String(describing: schedule.station?.title))")
        } catch {
            print("❌ Error fetching station schedule: \(error)")
        }
    }
    
    func testFetchRouteStations() async {
        do {
            let service = makeService(RouteStationsService.self)
            print("Fetching route stations...")
            
            let thread = try await service.getRouteStations(
                thread: "028M_1_2",
                date: getISO8601String())
            
            print("✅ Successfully fetched route stations: \(String(describing: thread.title))")
        } catch {
            print("❌ Error fetching route stations: \(error)")
        }
    }
    
    func testFetchNearestCity() async {
        do {
            let service = makeService(NearestCityService.self)
            print("Fetching nearest city...")
            
            let city = try await service.getNearestCity(
                lat: 59.864177,
                lng: 30.319163)
            
            print("✅ Successfully fetched nearest city: \(String(describing: city.title))")
        } catch {
            print("❌ Error fetching nearest city: \(error)")
        }
    }
    
    func testFetchCarrierInfo() async {
        do {
            let service = makeService(CarrierInfoService.self)
            print("Fetching carrier info...")
            
            let carrier = try await service.getCarrierInfo(code: "680")
            
            print("✅ Successfully fetched carrier info.: \(String(describing: carrier.carrier?.title ))")
        } catch {
            print("❌ Error fetching carrier info.: \(error)")
        }
    }
    
    func testFetchStationsList() async {
        do {
            let service = makeService(StationsListService.self)
            print("Fetching stations list...")
            
            let stations = try await service.getAllStations()
            
            print("✅ Successfully fetched stations list.: \(String(describing: stations.countries?.count ))")
        } catch {
            print("❌ Error fetching stations list.: \(error)")
        }
    }
    
    func testFetchCopyright() async {
        do {
            let service = makeService(CopyrightService.self)
            print("Fetching copyright...")
            
            let copyright = try await service.getCopyright()
            
            print("✅ Successfully fetched copyright.: \(String(describing: copyright.copyright?.text ))")
        } catch {
            print("❌ Error fetching copyright.: \(error)")
        }
    }
    
    func makeService<T: APIService>(_ type: T.Type) -> T {
        let client = try! Client(
            serverURL: Servers.Server1.url(),
            transport: URLSessionTransport()
        )
        
        return T(
            client: client,
            apikey: "39ebe8a8-df24-4caa-8c92-824abae7196d"
        )
    }
    
    func getISO8601String() -> String {
        let formatter = ISO8601DateFormatter()
        return formatter.string(from: Date())
    }
}


#Preview {
    ContentView().environment(\.managedObjectContext, PersistenceController.preview.container.viewContext)
}
