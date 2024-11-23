import consumer from "channels/consumer"

const messageChannel = consumer.subscriptions.create("MessageChannel", {
  connected() {
    // Called when the subscription is ready for use on the server
  },

  disconnected() {
    // Called when the subscription has been terminated by the server
  },

  received(data) {
    const messageDisplay = document.querySelector('#message-display')
    messageDisplay.insertAdjacentHTML('beforeend', this.template(data))
  },

  template(data) {
    return `<article class="message">
                <div class="message-header">
                    <p>${data.user.email}</p>}
                </div>
                <div class="message-body">
                    <p>${data.message.body}</p>
                </div>
            </article>`
  }
});

document.addEventListener("turbo:load", () => {
    let form = document.querySelector("#message-form");
    if (form) {
        form.addEventListener('submit', (e) => {
            e.preventDefault();
            const messageInput = document.querySelector("#message-input");
            if (messageInput.value == '') return;

            const message = {
                body: messageInput.value
            }

            messageInput.value = '';
            messageChannel.send({ message: message });
        })
    }
})
