Mox.defmock(MockWriter, for: WriterBehaviour)
Mox.defmock(MockReader, for: ReaderBehaviour)
Mox.defmock(MockRandomizer, for: RandomizerBehaviour)

ExUnit.configure(formatters: [JUnitFormatter, ExUnit.CLIFormatter])
ExUnit.start()

{:ok, files} = File.ls("./test/support")

Enum.each(files, fn file ->
  Code.require_file("support/#{file}", __DIR__)
end)
