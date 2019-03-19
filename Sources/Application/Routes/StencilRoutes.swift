import KituraStencil
import Kitura

var pizzeList:[Pizza] = []

func initializeStencilRoutes(app: App) {
    app.router.all(middleware: BodyParser())
    app.router.add(templateEngine: StencilTemplateEngine())
    app.router.get("/show") { request, response, next in
        try response.render("pizza.stencil", context: ["pizzas": pizzeList])
        next()
    }


    app.router.get("/create"){ request, response, next in
        let pizza = Pizza(title: "Margharita",Ingredient: ["Tomate","Fromage"])
        try response.render("create.stencil", with:pizza)
        next()
    }

    app.router.post("/create"){ request, response, next in
        if let body = request.body?.asURLEncoded {
            if let nameRecipe: String = (body["title"] as! String), let ingredientsRecipe: String = (body["Ingredient"] as! String) {
                print("Pizza : ", nameRecipe)
                print("Ingrédients : ", ingredientsRecipe)
                let ingredientsRecipeTab = ingredientsRecipe.components(separatedBy: ",")
                var ingredientsRecipeTabTrimmed: [String] = []
                for item in ingredientsRecipeTab {
                    ingredientsRecipeTabTrimmed.append(item.trimmingCharacters(in: .whitespacesAndNewlines))
                }
                
                let pizza = Pizza(title: nameRecipe, Ingredient: ingredientsRecipeTabTrimmed)
                pizzeList.append(pizza)
                //try response.render("pizza.stencil", context: ["pizzas": pizzeList])
                try response.render("create.stencil", context: ["isCreated": "New Pizza Created"])

            }
        } else {
            response.status(.notFound)
        }
    }
}
