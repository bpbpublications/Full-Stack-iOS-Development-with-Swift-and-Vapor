import Vapor

struct Movies: Content {
    let name: String
    let releaseYear: String
}

func routes(_ app: Application) throws {
    
    app.get { req -> EventLoopFuture<View> in
        req.view.render("index", Movies(name: "Harry Potter and the Philosopher's Stone", releaseYear: "2001"))
    }
    
    try app.register(collection: UserController())
}
