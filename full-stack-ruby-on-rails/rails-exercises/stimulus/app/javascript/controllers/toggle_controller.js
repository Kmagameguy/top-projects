import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = ["toggleable"]

    toggle() {
        this.toggleableTargets.forEach((element) => {
            element.classList.toggle("hidden")
        })
    }
}
