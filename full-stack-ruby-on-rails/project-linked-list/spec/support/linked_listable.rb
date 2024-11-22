# frozen_string_literal: true

# A helper module to quickly create a LinkedList for use in tests
module LinkedListable
  def create_linked_list_with_several_appended_nodes
    list = LinkedList.new
    list.append(10)
    list.append(20)
    list.append(30)

    list
  end

  def create_linked_list_with_several_prefixed_nodes
    list = LinkedList.new
    list.prefix(10)
    list.prefix(20)
    list.prefix(30)

    list
  end
end
