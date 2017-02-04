defmodule FunWithFlags.StoreTest do
  use ExUnit.Case, async: true
  import FunWithFlags.TestUtils

  alias FunWithFlags.Store

  test "looking up an undefined flag returns false" do
    flag_name = unique_atom()
    assert false == Store.lookup(flag_name)
  end

  test "put() can change the value of a flag" do
    flag_name = unique_atom()

    assert false == Store.lookup(flag_name)
    Store.put(flag_name, true)
    assert true == Store.lookup(flag_name)
    Store.put(flag_name, false)
    assert false == Store.lookup(flag_name)
  end

  describe "unit: enable and disable with this module's API" do
    test "looking up a disabled flag returns false" do
      flag_name = unique_atom()
      Store.put(flag_name, false)
      assert false == Store.lookup(flag_name)
    end

    test "looking up an enabled flag returns true" do
      flag_name = unique_atom()
      Store.put(flag_name, true)
      assert true == Store.lookup(flag_name)
    end
  end

  describe "integration: enable and disable with the top-level API" do
    test "looking up a disabled flag returns false" do
      flag_name = unique_atom()
      FunWithFlags.disable(flag_name)
      assert false == Store.lookup(flag_name)
    end

    test "looking up an enabled flag returns true" do
      flag_name = unique_atom()
      FunWithFlags.enable(flag_name)
      assert true == Store.lookup(flag_name)
    end
  end
end
