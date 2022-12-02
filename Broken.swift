import Foundation

protocol EmptyInitable {
    init()
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
