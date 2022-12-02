# swift-actor-functions-bug

The `isolated` keyword in the passed closure could be the culprit!

Just run on macOS or Windows with 5.7.1 Release:

`swift build -Xswiftc -DNOT_BROKEN`

and all is well! But if you run:

`swift build` or, to get an understandable error: `swift build --use-integrated-swift-driver`

you get (on macOS, for example):

```
[0/1] Planning build
Building for debugging...
Assertion failed: (param->getInterfaceType() ->lookThroughAllOptionalTypes() ->castTo<AnyFunctionType>() ->hasEffect(kind) || !param->getInterfaceType() ->lookThroughAllOptionalTypes() ->castTo<AnyFunctionType>() ->getGlobalActor().isNull()), function classifyParameterBody, file TypeCheckEffects.cpp, line 908.
Please submit a bug report (https://swift.org/contributing/#reporting-bugs) and include the project and the crash backtrace.
Stack dump:
0.	Program arguments: /Users/runner/hostedtoolcache/swift-macOS/5.7.1/x64/usr/bin/swiftc -frontend -c -primary-file /Users/runner/work/swift-actor-functions-bug/swift-actor-functions-bug/Sources/swift-actor-functions-bug/Test.swift -emit-dependencies-path /Users/runner/work/swift-actor-functions-bug/swift-actor-functions-bug/.build/x86_64-apple-macosx/debug/swift_actor_functions_bug.build/Test.d -emit-reference-dependencies-path /Users/runner/work/swift-actor-functions-bug/swift-actor-functions-bug/.build/x86_64-apple-macosx/debug/swift_actor_functions_bug.build/Test.swiftdeps -target x86_64-apple-macosx12.0 -enable-objc-interop -sdk /Applications/Xcode_14.0.1.app/Contents/Developer/Platforms/MacOSX.platform/Developer/SDKs/MacOSX12.3.sdk -I /Users/runner/work/swift-actor-functions-bug/swift-actor-functions-bug/.build/x86_64-apple-macosx/debug -I /Applications/Xcode_14.0.1.app/Contents/Developer/Platforms/MacOSX.platform/Developer/usr/lib -F /Applications/Xcode_14.0.1.app/Contents/Developer/Platforms/MacOSX.platform/Developer/Library/Frameworks -enable-testing -g -module-cache-path /Users/runner/work/swift-actor-functions-bug/swift-actor-functions-bug/.build/x86_64-apple-macosx/debug/ModuleCache -swift-version 5 -Onone -D SWIFT_PACKAGE -D DEBUG -empty-abi-descriptor -resource-dir /Users/runner/hostedtoolcache/swift-macOS/5.7.1/x64/usr/lib/swift -enable-anonymous-context-mangled-names -module-name swift_actor_functions_bug -target-sdk-version 12.3 -parse-as-library -o /Users/runner/work/swift-actor-functions-bug/swift-actor-functions-bug/.build/x86_64-apple-macosx/debug/swift_actor_functions_bug.build/Test.swift.o -index-store-path /Users/runner/work/swift-actor-functions-bug/swift-actor-functions-bug/.build/x86_64-apple-macosx/debug/index/store -index-system-modules
1.	Apple Swift version 5.7.1 (swift-5.7.1-RELEASE)
2.	Compiling with the current language version
3.	While evaluating request TypeCheckSourceFileRequest(source_file "/Users/runner/work/swift-actor-functions-bug/swift-actor-functions-bug/Sources/swift-actor-functions-bug/Test.swift")
4.	While evaluating request TypeCheckFunctionBodyRequest(swift_actor_functions_bug.(file).ActorFunctionConsumer.init(_:)@/Users/runner/work/swift-actor-functions-bug/swift-actor-functions-bug/Sources/swift-actor-functions-bug/Test.swift:16:5)
5.	While checking effects handling for 'init(_:)' (at /Users/runner/work/swift-actor-functions-bug/swift-actor-functions-bug/Sources/swift-actor-functions-bug/Test.swift:16:5)
Stack dump without symbol names (ensure you have llvm-symbolizer in your PATH or set the environment var `LLVM_SYMBOLIZER_PATH` to point to it):
0  swift-frontend           0x0000000107093137 llvm::sys::PrintStackTrace(llvm::raw_ostream&, int) + 39
1  swift-frontend           0x0000000107092355 llvm::sys::RunSignalHandlers() + 85
2  swift-frontend           0x0000000107093770 SignalHandler(int) + 288
3  libsystem_platform.dylib 0x00007ff8179a6dfd _sigtramp + 29
4  libsystem_platform.dylib 0x00007ff7bdfd9728 _sigtramp + 18446744072206100808
5  libsystem_c.dylib        0x00007ff8178dcd24 abort + 123
6  libsystem_c.dylib        0x00007ff8178dc0cb err + 0
7  swift-frontend           0x0000000107515373 (anonymous namespace)::ApplyClassifier::classifyFunctionBody((anonymous namespace)::AbstractFunction const&, (anonymous namespace)::PotentialEffectReason, swift::EffectKind) (.cold.7) + 35
8  swift-frontend           0x0000000102efa740 (anonymous namespace)::ApplyClassifier::classifyFunctionBody((anonymous namespace)::AbstractFunction const&, (anonymous namespace)::PotentialEffectReason, swift::EffectKind) + 1584
9  swift-frontend           0x0000000102ef92da (anonymous namespace)::ApplyClassifier::classifyApply(swift::ApplyExpr*)::'lambda'(swift::EffectKind)::operator()(swift::EffectKind) const + 1194
10 swift-frontend           0x0000000102ef7ed3 (anonymous namespace)::ApplyClassifier::classifyApply(swift::ApplyExpr*) + 723
11 swift-frontend           0x0000000102ef5d15 (anonymous namespace)::EffectsHandlingWalker<(anonymous namespace)::CheckEffectsCoverage>::walkToExprPre(swift::Expr*) + 1893
12 swift-frontend           0x000000010328e19a swift::ASTVisitor<(anonymous namespace)::Traversal, swift::Expr*, swift::Stmt*, bool, swift::Pattern*, bool, void>::visit(swift::Expr*) + 474
13 swift-frontend           0x000000010328f006 swift::ASTVisitor<(anonymous namespace)::Traversal, swift::Expr*, swift::Stmt*, bool, swift::Pattern*, bool, void>::visit(swift::Expr*) + 4166
14 swift-frontend           0x000000010328e730 swift::ASTVisitor<(anonymous namespace)::Traversal, swift::Expr*, swift::Stmt*, bool, swift::Pattern*, bool, void>::visit(swift::Expr*) + 1904
15 swift-frontend           0x000000010328e092 swift::ASTVisitor<(anonymous namespace)::Traversal, swift::Expr*, swift::Stmt*, bool, swift::Pattern*, bool, void>::visit(swift::Expr*) + 210
16 swift-frontend           0x000000010328df28 (anonymous namespace)::Traversal::doIt(swift::ArgumentList*) + 184
17 swift-frontend           0x000000010328e201 swift::ASTVisitor<(anonymous namespace)::Traversal, swift::Expr*, swift::Stmt*, bool, swift::Pattern*, bool, void>::visit(swift::Expr*) + 577
18 swift-frontend           0x000000010328d819 swift::Expr::walk(swift::ASTWalker&) + 73
19 swift-frontend           0x0000000102ef5999 (anonymous namespace)::EffectsHandlingWalker<(anonymous namespace)::CheckEffectsCoverage>::walkToExprPre(swift::Expr*) + 1001
20 swift-frontend           0x000000010328fecd swift::ASTVisitor<(anonymous namespace)::Traversal, swift::Expr*, swift::Stmt*, bool, swift::Pattern*, bool, void>::visit(swift::Stmt*) + 157
21 swift-frontend           0x000000010328d88f swift::Stmt::walk(swift::ASTWalker&) + 79
22 swift-frontend           0x0000000102ef5060 swift::TypeChecker::checkFunctionEffects(swift::AbstractFunctionDecl*) + 896
23 swift-frontend           0x0000000102f6e881 swift::TypeCheckFunctionBodyRequest::evaluate(swift::Evaluator&, swift::AbstractFunctionDecl*) const + 2753
24 swift-frontend           0x000000010339953d llvm::Expected<swift::TypeCheckFunctionBodyRequest::OutputType> swift::Evaluator::getResultUncached<swift::TypeCheckFunctionBodyRequest>(swift::TypeCheckFunctionBodyRequest const&) + 429
25 swift-frontend           0x00000001033992b7 llvm::Expected<swift::TypeCheckFunctionBodyRequest::OutputType> swift::Evaluator::getResultCached<swift::TypeCheckFunctionBodyRequest, (void*)0>(swift::TypeCheckFunctionBodyRequest const&) + 119
26 swift-frontend           0x00000001032eea41 swift::TypeCheckFunctionBodyRequest::OutputType swift::evaluateOrDefault<swift::TypeCheckFunctionBodyRequest>(swift::Evaluator&, swift::TypeCheckFunctionBodyRequest, swift::TypeCheckFunctionBodyRequest::OutputType) + 49
27 swift-frontend           0x0000000102fa2d26 swift::TypeCheckSourceFileRequest::evaluate(swift::Evaluator&, swift::SourceFile*) const + 326
28 swift-frontend           0x0000000102fa4dbe llvm::Expected<swift::TypeCheckSourceFileRequest::OutputType> swift::Evaluator::getResultUncached<swift::TypeCheckSourceFileRequest>(swift::TypeCheckSourceFileRequest const&) + 430
29 swift-frontend           0x0000000102fa4b42 llvm::Expected<swift::TypeCheckSourceFileRequest::OutputType> swift::Evaluator::getResultCached<swift::TypeCheckSourceFileRequest, (void*)0>(swift::TypeCheckSourceFileRequest const&) + 114
30 swift-frontend           0x0000000102fa2acd swift::TypeCheckSourceFileRequest::OutputType swift::evaluateOrDefault<swift::TypeCheckSourceFileRequest>(swift::Evaluator&, swift::TypeCheckSourceFileRequest, swift::TypeCheckSourceFileRequest::OutputType) + 45
31 swift-frontend           0x00000001020e9abc bool llvm::function_ref<bool (swift::SourceFile&)>::callback_fn<swift::CompilerInstance::performSema()::$_7>(long, swift::SourceFile&) + 12
32 swift-frontend           0x00000001020e4f5b swift::CompilerInstance::forEachFileToTypeCheck(llvm::function_ref<bool (swift::SourceFile&)>) + 91
33 swift-frontend           0x00000001020e4edb swift::CompilerInstance::performSema() + 75
34 swift-frontend           0x000000010207b6b1 swift::performFrontend(llvm::ArrayRef<char const*>, char const*, void*, swift::FrontendObserver*) + 4129
35 swift-frontend           0x0000000101f43ca4 swift::mainEntry(int, char const**) + 3236
36 dyld                     0x0000000114cc252e start + 462
[0/1] Compiling swift_actor_functions_bug Test.swift
Error: Process completed with exit code 1.
