# swift-actor-functions-bug

Just run on macOS or Windows with 5.7.1 Release:

`swiftc BrokenOnWindows.swift`

and get (on macOS, for example):

```
error: compile command failed due to signal 6 (use -v to see invocation)
Assertion failed: (param->getInterfaceType() ->lookThroughAllOptionalTypes() ->castTo<AnyFunctionType>() ->hasEffect(kind) || !param->getInterfaceType() ->lookThroughAllOptionalTypes() ->castTo<AnyFunctionType>() ->getGlobalActor().isNull()), function classifyParameterBody, file TypeCheckEffects.cpp, line 908.
Please submit a bug report (https://swift.org/contributing/#reporting-bugs) and include the project and the crash backtrace.
Stack dump:
0.	Program arguments: /Users/runner/hostedtoolcache/swift-macOS/5.7.1/x64/usr/bin/swift-frontend -frontend -c -primary-file BrokenOnWindows.swift -target x86_64-apple-macosx12.0 -enable-objc-interop -new-driver-path /Users/runner/hostedtoolcache/swift-macOS/5.7.1/x64/usr/bin/swift-driver -empty-abi-descriptor -resource-dir /Users/runner/hostedtoolcache/swift-macOS/5.7.1/x64/usr/lib/swift -module-name BrokenOnWindows -o /var/folders/24/8k48jl6d249_n_qfxwsl6xvm0000gn/T/TemporaryDirectory.ddeL3G/BrokenOnWindows-1.o
1.	Apple Swift version 5.7.1 (swift-5.7.1-RELEASE)
2.	Compiling with the current language version
3.	While evaluating request TypeCheckSourceFileRequest(source_file "BrokenOnWindows.swift")
4.	While evaluating request TypeCheckFunctionBodyRequest(BrokenOnWindows.(file).ActorFunctionConsumer.init(_:)@BrokenOnWindows.swift:19:5)
5.	While checking effects handling for 'init(_:)' (at BrokenOnWindows.swift:19:5)
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  swift-frontend           0x000000010c82b137 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 39
1  swift-frontend           0x000000010c82a355 llvm::sys::RunSignalHandlers() + 85
2  swift-frontend           0x000000010c82b770 SignalHandler(int) + 288
3  libsystem_platform.dylib 0x00007ff806ecedfd _sigtramp + 29
4  libsystem_platform.dylib 0x00007ff7b8841d58 _sigtramp + 18446744072394059640
5  libsystem_c.dylib        0x00007ff806e04d24 abort + 123
6  libsystem_c.dylib        0x00007ff806e040cb err + 0
7  swift-frontend           0x000000010ccad373 (anonymous namespace)::ApplyClassifier::classifyFunctionBody((anonymous namespace)::AbstractFunction const&, (anonymous namespace)::PotentialEffectReason, swift::EffectKind) (.cold.7) + 35
8  swift-frontend           0x0000000108692740 (anonymous namespace)::ApplyClassifier::classifyFunctionBody((anonymous namespace)::AbstractFunction const&, (anonymous namespace)::PotentialEffectReason, swift::EffectKind) + 1584
9  swift-frontend           0x00000001086912da (anonymous namespace)::ApplyClassifier::classifyApply(swift::ApplyExpr*)::'lambda'(swift::EffectKind)::operator()(swift::EffectKind) const + 1194
10 swift-frontend           0x000000010868fed3 (anonymous namespace)::ApplyClassifier::classifyApply(swift::ApplyExpr*) + 723
11 swift-frontend           0x000000010868dd15 (anonymous namespace)::EffectsHandlingWalker<(anonymous namespace)::CheckEffectsCoverage>::walkToExprPre(swift::Expr*) + 1893
12 swift-frontend           0x0000000108a2619a swift::ASTVisitor<(anonymous namespace)::Traversal, swift::Expr*, swift::Stmt*, bool, swift::Pattern*, bool, void>::visit(swift::Expr*) + 474
13 swift-frontend           0x0000000108a27006 swift::ASTVisitor<(anonymous namespace)::Traversal, swift::Expr*, swift::Stmt*, bool, swift::Pattern*, bool, void>::visit(swift::Expr*) + 4166
14 swift-frontend           0x0000000108a26730 swift::ASTVisitor<(anonymous namespace)::Traversal, swift::Expr*, swift::Stmt*, bool, swift::Pattern*, bool, void>::visit(swift::Expr*) + 1904
15 swift-frontend           0x0000000108a26092 swift::ASTVisitor<(anonymous namespace)::Traversal, swift::Expr*, swift::Stmt*, bool, swift::Pattern*, bool, void>::visit(swift::Expr*) + 210
16 swift-frontend           0x0000000108a25f28 (anonymous namespace)::Traversal::doIt(swift::ArgumentList*) + 184
17 swift-frontend           0x0000000108a26201 swift::ASTVisitor<(anonymous namespace)::Traversal, swift::Expr*, swift::Stmt*, bool, swift::Pattern*, bool, void>::visit(swift::Expr*) + 577
18 swift-frontend           0x0000000108a25819 swift::Expr::walk(swift::ASTWalker&) + 73
19 swift-frontend           0x000000010868d999 (anonymous namespace)::EffectsHandlingWalker<(anonymous namespace)::CheckEffectsCoverage>::walkToExprPre(swift::Expr*) + 1001
20 swift-frontend           0x0000000108a27ecd swift::ASTVisitor<(anonymous namespace)::Traversal, swift::Expr*, swift::Stmt*, bool, swift::Pattern*, bool, void>::visit(swift::Stmt*) + 157
21 swift-frontend           0x0000000108a2588f swift::Stmt::walk(swift::ASTWalker&) + 79
22 swift-frontend           0x000000010868d060 swift::TypeChecker::checkFunctionEffects(swift::AbstractFunctionDecl*) + 896
23 swift-frontend           0x0000000108706881 swift::TypeCheckFunctionBodyRequest::evaluate(swift::Evaluator&, swift::AbstractFunctionDecl*) const + 2753
24 swift-frontend           0x0000000108b3153d llvm::Expected<swift::TypeCheckFunctionBodyRequest::OutputType> swift::Evaluator::getResultUncached<swift::TypeCheckFunctionBodyRequest>(swift::TypeCheckFunctionBodyRequest const&) + 429
25 swift-frontend           0x0000000108b312b7 llvm::Expected<swift::TypeCheckFunctionBodyRequest::OutputType> swift::Evaluator::getResultCached<swift::TypeCheckFunctionBodyRequest, (void*)0>(swift::TypeCheckFunctionBodyRequest const&) + 119
26 swift-frontend           0x0000000108a86a41 swift::TypeCheckFunctionBodyRequest::OutputType swift::evaluateOrDefault<swift::TypeCheckFunctionBodyRequest>(swift::Evaluator&, swift::TypeCheckFunctionBodyRequest, swift::TypeCheckFunctionBodyRequest::OutputType) + 49
27 swift-frontend           0x000000010873ad26 swift::TypeCheckSourceFileRequest::evaluate(swift::Evaluator&, swift::SourceFile*) const + 326
28 swift-frontend           0x000000010873cdbe llvm::Expected<swift::TypeCheckSourceFileRequest::OutputType> swift::Evaluator::getResultUncached<swift::TypeCheckSourceFileRequest>(swift::TypeCheckSourceFileRequest const&) + 430
29 swift-frontend           0x000000010873cb42 llvm::Expected<swift::TypeCheckSourceFileRequest::OutputType> swift::Evaluator::getResultCached<swift::TypeCheckSourceFileRequest, (void*)0>(swift::TypeCheckSourceFileRequest const&) + 114
30 swift-frontend           0x000000010873aacd swift::TypeCheckSourceFileRequest::OutputType swift::evaluateOrDefault<swift::TypeCheckSourceFileRequest>(swift::Evaluator&, swift::TypeCheckSourceFileRequest, swift::TypeCheckSourceFileRequest::OutputType) + 45
31 swift-frontend           0x0000000107881abc bool llvm::function_ref<bool (swift::SourceFile&)>::callback_fn<swift::CompilerInstance::performSema()::$_7>(long, swift::SourceFile&) + 12
32 swift-frontend           0x000000010787cf5b swift::CompilerInstance::forEachFileToTypeCheck(llvm::function_ref<bool (swift::SourceFile&)>) + 91
33 swift-frontend           0x000000010787cedb swift::CompilerInstance::performSema() + 75
34 swift-frontend           0x00000001078136b1 swift::performFrontend(llvm::ArrayRef<char const*>, char const*, void*, swift::FrontendObserver*) + 4129
35 swift-frontend           0x00000001076dbca4 swift::mainEntry(int, char const**) + 3236
36 dyld                     0x000000011e06e52e start + 462
Error: Process completed with exit code 1.
