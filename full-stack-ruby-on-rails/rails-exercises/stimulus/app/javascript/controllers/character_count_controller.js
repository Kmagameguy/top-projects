import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ['input', 'count']
    static values = { limit: { type: Number, default: 280 } }

    initialize() {
        this.countTarget.textContent = this.limitValue
        this.inputTarget.maxLength = this.limitValue
    }

    calculate() {
        this.countTarget.textContent = this.availableCharacters()
        if (this.inputTarget.value.length > this.limitValue * 0.75 ) {
            this.countTarget.classList.add('danger')
        } else {
            this.countTarget.classList.remove('danger')
        }
    }

    availableCharacters() {
        return this.limitValue - this.inputTarget.value.length
    }
}
