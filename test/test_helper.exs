Mox.defmock(MockWriter, for: WriterBehaviour)
Mox.defmock(MockReader, for: ReaderBehaviour)

ExUnit.configure(formatters: [JUnitFormatter, ExUnit.CLIFormatter])
ExUnit.start()
