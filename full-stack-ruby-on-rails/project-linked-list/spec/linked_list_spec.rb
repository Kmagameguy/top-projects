# frozen_string_literal: true

require_relative '../lib/linked_list'

RSpec.describe 'Linked List' do
  describe 'creating linked lists' do
    it 'creates an empty list' do
      list = LinkedList.new
      expect(list.head).to be_nil
    end
  end

  describe 'adding to the end of linked lists' do
    it 'adds nodes to the end of the list' do
      list = LinkedList.new
      expect(list.tail).to be_nil

      list.append(10)
      expect(list.tail.data).to eq 10

      list.append(20)
      expect(list.tail.data).to eq 20
    end
  end

  describe 'adding to the beginning of linked lists' do
    it 'adds a node to the beginning of the linked list' do
      list = LinkedList.new
      expect(list.head).to be_nil

      list.prefix(100)
      expect(list.head.data).to be 100

      list.prefix(20)
      expect(list.head.data).to be 20
    end
  end

  describe 'adding to start and end of linked lists' do
    it 'prefixes and appends nodes to the linked list' do
      list = LinkedList.new.tap do |ll|
        ll.append(10)
        ll.append(20)
        ll.append(30)
        ll.prefix(100)
      end
      expect(list.head.data).to be 100
      expect(list.tail.data).to be 30
    end
  end

  describe 'calculating the size of linked lists' do
    let(:populated_list) {
      LinkedList.new.tap do | ll |
        ll.append(10)
        ll.append(20)
        ll.append(30)
      end
    }
    it 'returns 0 if linked list is empty' do
      list = LinkedList.new
      expect(list.size).to be 0
    end

    it 'returns the number of nodes in the linked list' do
      list = populated_list
      expect(list.size).to be 3
    end
  end

  describe 'using head and tail convenience methods' do
    let(:populated_list) {
      LinkedList.new.tap do | ll |
        ll.append(10)
        ll.append(20)
        ll.append(30)
      end
    }
    it 'returns the value of the head node' do
      list = populated_list
      expect(list.head.data).to be 10
    end

    it 'returns the value of the tail node' do
      list = populated_list
      expect(list.tail.data).to be 30
    end
  end

  describe 'finding nodes within the linked list' do
    let(:populated_list) {
      LinkedList.new.tap do | ll |
        ll.append(10)
        ll.append(20)
        ll.append(30)
      end
    }
    it 'returns nil if linked list is empty' do
      list = LinkedList.new
      expect(list.at(0)).to be nil
    end

    it 'returns nil if index is not within the linked list range' do
      list = populated_list
      expect(list.at(-3)).to be nil
      expect(list.at(8)).to be nil
    end

    it 'returns the node at the specified index' do
      list = populated_list
      expect(list.at(1).data).to be 20
    end
  end

  describe 'removing nodes from the end of the linked list' do
    let(:populated_list) {
      LinkedList.new.tap do | ll |
        ll.append(10)
        ll.append(20)
        ll.append(30)
      end
    }
    it 'does nothing if the linked list is empty when calling pop' do
      list = LinkedList.new
      expect(list.pop).to be nil
      expect(list.size).to be 0
    end

    it 'uses pop to remove the last element from the list' do
      list = populated_list
      expect(list.pop.data).to be 30
      tail = list.tail
      expect(tail.data).to be 20
      expect(tail.next).to be nil
      expect(list.size).to be 2
    end
  end

  describe 'mixing data inside linked lists' do
    it 'accepts data of any kind' do
      list = LinkedList.new
      var = 'i like turtles'
      list.append(10)
      list.append('hello')
      list.append(10 + 2)
      list.append(nil)
      list.append(var)
      list.append(true)
      expect(list.head.data).to be 10
      expect(list.at(1).data).to eql('hello')
      expect(list.at(2).data).to be 12
      expect(list.at(3).data).to be nil
      expect(list.at(4).data).to eql('i like turtles')
      expect(list.tail.data).to be true
      expect(list.size).to be 6
    end
  end

  describe 'retrieving data from the linked list' do
    let(:populated_list) {
      LinkedList.new.tap do | ll |
        ll.append(10)
        ll.append(20)
        ll.append(30)
      end
    }
    it 'is false if a linked list is empty when calling contains?(value)' do
      list = LinkedList.new
      expect(list.contains?(10)).to be false
    end

    it 'is false if the queried value does not exist in the linked list' do
      list = populated_list
      expect(list.contains?('Cowabunga')).to be false
    end

    it 'is true if the queried value exists in the linked list' do
      list = populated_list
      expect(list.contains?(30)).to be true
    end
  end

  describe 'finding the index of a value inside the linked list' do
    let(:populated_list) {
      LinkedList.new.tap do | ll |
        ll.append(10)
        ll.append(20)
        ll.append(30)
      end
    }
    it 'is nil if the list is empty' do
      list = LinkedList.new
      expect(list.find('bob')).to be nil
    end

    it 'is nil if the value does not exist in the linked list' do
      list = populated_list
      expect(list.find('bob')).to be nil
    end

    it 'shows the index of the node which contains the queried value' do
      list = populated_list
      list.append('bob')
      expect(list.find('bob')).to be 3
    end
  end

  describe 'printing the linked list' do
    let(:populated_list) {
      LinkedList.new.tap do | ll |
        ll.append(10)
        ll.append(20)
        ll.append(30)
      end
    }
    it 'renders nil if the linked list is empty' do
      list = LinkedList.new
      expect(list.to_s).to be nil
    end

    it 'renders the data of each node if the linked list is not empty' do
      list = populated_list
      list.prefix('bob')
      list.prefix(100)
      expect(list.to_s).to eq '( 100 ) -> ( bob ) -> ( 10 ) -> ( 20 ) -> ( 30 ) -> nil'
    end
  end

  describe 'inserting nodes at a specified index' do
    let(:populated_list) {
      LinkedList.new.tap do | ll |
        ll.append(10)
        ll.append(20)
        ll.append(30)
      end
    }
    it 'creates a node at HEAD regardless of index if list is empty' do
      list = LinkedList.new
      list.insert_at('bob', 20)
      expect(list.head.data).to eq 'bob'
      expect(list.size).to be 1
    end

    it 'creates a node at HEAD if index is negative' do
      list = populated_list
      list.insert_at('bob', -7)
      expect(list.head.data).to eq 'bob'
      expect(list.at(1).data).to be 10
      expect(list.size).to be 4
    end

    it 'creates a node at TAIL if positive index is out of range' do
      list = populated_list
      list.insert_at('bob', 300)
      expect(list.tail.data).to eq 'bob'
      expect(list.size).to be 4
    end

    it 'creates a node at the specified index if index is between HEAD and TAIL' do
      list = populated_list
      list.append(40)
      list.append(50)
      list.insert_at('hello', 2)
      expect(list.at(2).data).to eq 'hello'
      expect(list.at(1).data).to be 20
      expect(list.at(3).data).to be 30
      expect(list.size).to be 6
    end
  end

  describe 'removing nodes at a specified index' do
    let(:populated_list) {
      LinkedList.new.tap do | ll |
        ll.append(10)
        ll.append(20)
        ll.append(30)
      end
    }
    it 'does nothing if the list is empty' do
      list = LinkedList.new
      original_size = list.size
      list.remove_at(0)
      expect(list.size).to eq original_size
    end

    it 'does nothing if the supplied index is a negative value' do
      list = populated_list
      original_list_size = list.size
      list.remove_at(-1)
      expect(list.size).to eq original_list_size
    end

    it 'does nothing if the supplied index is greater than the list length' do
      list = populated_list
      original_list_size = list.size
      list.remove_at(3000)
      expect(list.size).to eq original_list_size
    end

    it 'sets head to nil if head is removed and was only node in list' do
      list = LinkedList.new
      list.append(10)
      list.remove_at(0)
      expect(list.head).to be nil
      expect(list.size).to be 0
    end

    it 'sets head to the next node if head is removed' do
      list = populated_list
      list.remove_at(0)
      expect(list.head.data).to be 20
      expect(list.size).to be 2
    end

    it 'removes the node at the specified index' do
      list = populated_list
      list.append('Cowabunga')
      list.append(40)
      list.remove_at(3)
      expect(list.at(2).data).to be 30
      expect(list.at(3).data).to be 40
      expect(list.contains?('Cowabunga')).to be false
      expect(list.size).to be 4
    end
  end
end
