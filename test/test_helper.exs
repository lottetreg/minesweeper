Mox.defmock(MockWriter, for: WriterBehaviour)
Mox.defmock(MockReader, for: ReaderBehaviour)
Mox.defmock(MockRandomizer, for: RandomizerBehaviour)

ExUnit.configure(formatters: [JUnitFormatter, ExUnit.CLIFormatter])
ExUnit.start()
