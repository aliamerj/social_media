import consumer from "./consumer";

const initialChatChannel = (conversation_id) =>
  consumer.subscriptions.create(
    { channel: "ChatChannel", conversation_id: conversation_id },
    {
      connected() {
        console.log("Connected to ChatChannel");
        // Called when the subscription is ready for use on the server
      },

      disconnected() {
        console.log("Disconnected from ChatChannel");
        // Called when the subscription has been terminated by the server
      },

      received(data) {
        console.log("received :::", data);
        // Called when there's incoming data on the websocket for this channel
        const messageContainer = document.getElementById("message-container");

        const senderHTML = `
      <div class="d-flex flex-row justify-content-end mb-4 pt-1">
      <div>
        <p class="small p-2 me-3 mb-1 text-white rounded-3 bg-primary" >${data.body}</p>
      </div>
        <img src="${data.sender.avatar.url}" alt="avatar" class="avatar-user" />
      </div>
    `;
        const receiverHTML = `
    <div class="d-flex flex-row justify-content-start">
    <img src="${data.sender.avatar.url}" alt="avatar" class="avatar-user" />
    <div>
      <p class="small p-2 ms-3 mb-1 rounded-3" style="background-color: #f5f6f7;">${data.body}</p>
    </div>
    </div>
    `;

        messageContainer.insertAdjacentHTML(
          "beforeend",
          data.sender.id == currentUserId ? senderHTML : receiverHTML
        );
        // Clear the input field
        const messageInput = document.getElementById("message_input");
        messageInput.value = "";
      },
    }
  );

const conversationPath = window.location.pathname
  .split("/")
  .filter((str) => str !== "");

const getConversationId = Number(conversationPath[1][0]);

if (conversationPath[0] === "conversations" && getConversationId) {
  initialChatChannel(getConversationId);
}

const currentUserId = document
  .getElementById("chat-container")
  .getAttribute("data-current-user-id");
