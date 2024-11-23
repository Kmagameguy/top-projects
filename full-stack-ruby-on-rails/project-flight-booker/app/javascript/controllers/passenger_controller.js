import { Controller } from "@hotwired/stimulus"

export default class extends Controller {
    static targets = [ "source", "row" ]
    static values = { count: Number }

    initialize() {
        this.countValue = this.countPassengerFields()
    }

    add(event) {
        event.preventDefault()

        if (this.countPassengerFields() == 4) {
            alert("You can only add up to 4 passengers")
            return
        }

        this.countValue++;
        const clone = this.rowTarget.content.cloneNode(true)

        const nameInputLabel = clone.querySelector("div>:first-child")
        const nameInput = clone.querySelector("div>:nth-child(2)")

        const emailInputLabel = clone.querySelector("div>:nth-child(3)")
        const emailInput = clone.querySelector("div>:nth-child(4)")

        this.setFieldProperties(nameInputLabel, nameInput, "name")
        this.setFieldProperties(emailInputLabel, emailInput, "email")

        this.sourceTarget.appendChild(clone)
    }

    remove(event) {
        event.preventDefault()

        if (this.countPassengerFields() > 1) {
            this.countValue--;
            event.target.parentElement.remove()
        } else {
            alert("You must have at least one passenger")
        }
    }

    countPassengerFields() {
        return document.querySelectorAll(".passenger-fields").length
    }

    setFieldProperties(label, input, type) {
        label.setAttribute("for", `booking_passengers_attributes_${this.countValue}_${type}`)

        this.setAttributes(input, {
            "id": `booking_passengers_attributes_${this.countValue}_${type}`,
            "name" : `booking[passengers_attributes][${this.countValue}][${type}]`
         })
    }

    setAttributes(element, attributes) {
        for (let key in attributes) {
            element.setAttribute(key, attributes[key])
        }
    }
}
