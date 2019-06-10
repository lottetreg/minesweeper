Mox.defmock(MockWriter, for: WriterBehaviour)
Mox.defmock(MockReader, for: ReaderBehaviour)
Mox.defmock(MockGameRules, for: GameRulesBehaviour)

ExUnit.configure(formatters: [JUnitFormatter, ExUnit.CLIFormatter])
ExUnit.start()
