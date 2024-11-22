# frozen_string_literal: true

# A helper module to quickly create a LinkedList for use in tests
module LinkedListable
  def create_linked_list_with_several_appended_nodes
    LinkedList.new.tap do |l|
      l.append(10)
      l.append(20)
      l.append(30)
    end
  end

  def create_linked_list_with_several_prefixed_nodes
    LinkedList.new.tap do |l|
      l.prefix(10)
      l.prefix(20)
      l.prefix(30)
    end
  end
end
