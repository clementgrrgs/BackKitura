import KituraContracts

func initializeCodableRoutes(app: App) {
    app.router.post("/codable", handler: app.postHandler)

    app.router.get("/codable", handler: app.getAllHandler)

}
extension App {
    static var codableStore = [Pizza]()
    
    func postHandler(pizza: Pizza, completion: (Pizza?, RequestError?) -> Void) {
        App.codableStore.append(pizza)
        completion(pizza, nil)
    }

    func getAllHandler(completion: ([Pizza]?, RequestError?) -> Void) {
        completion(App.codableStore, nil)
    }
}