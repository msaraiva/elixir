Code.require_file("../test_helper.exs", __DIR__)

defmodule Code.Formatter.CustomSigilTest do
  use ExUnit.Case, async: true

  import CodeFormatterHelpers

  defmodule MyFormatter do
    def format(entries, _meta) do
      entries
      |> to_string()
      |> String.split("\n")
      |> Enum.map_join("\n", &String.trim/1)
      |> List.wrap()
    end
  end

  test "ttt" do
    code =
      ~S'''
      defmodule A do
      def render() do
        ~H"""
        aaa
          bbb
        ccc
            ddd
        """
      end
      end
      '''

    result =
      ~S'''
      defmodule A do
        def render() do
          ~H"""
          aaa
          bbb
          ccc
          ddd
          """
        end
      end
      '''

    assert_format code, result, [sigil_formatters: [H: MyFormatter]]
  end
end
