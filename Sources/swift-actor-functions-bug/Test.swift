import Foundation

protocol EmptyInitable {
    init()
}

struct ActorFunctionConsumer<T> where T: Actor, T: EmptyInitable {
    #if NOT_BROKEN
    typealias Closure = (T) -> @Sendable (Int) async -> Int
    #else
    typealias Closure = (isolated T) -> @Sendable (Int) async -> Int
    #endif
    
    let closure: Closure

    init(_ closure: @escaping Closure) async {
        self.closure = closure

        let bogus = T()
        await print(closure(bogus)(5))
    }
}