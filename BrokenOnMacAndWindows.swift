protocol EmptyInitable {
    init()
}

actor TestActor: EmptyInitable {
    @Sendable func someFunc(input: Int) async -> Int {
        return input
    }

    static func exposeFunction() async -> ActorFunctionConsumer<TestActor> {
        await .init(TestActor.someFunc)
    }
}

struct ActorFunctionConsumer<T> where T: Actor, T: EmptyInitable {
    typealias Closure = (isolated T) -> @Sendable (Int) async -> Int
    let closure: Closure

    init(_ closure: @escaping Closure) async {
        self.closure = closure

        let bogus = T()
        await print(closure(bogus)(5))
    }
}
