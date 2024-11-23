import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["checkboxContainer"]

    toggle() {
        this.checkboxContainerTarget.classList.toggle('highlight')
    }
}
