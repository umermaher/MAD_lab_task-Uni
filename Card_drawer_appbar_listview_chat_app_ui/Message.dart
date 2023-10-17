


class Message {
  bool owned;
  String message;

  Message(this.message,this.owned);

  String getMessage() => message;
}

class Messages{
  List<Message> messages() {
    List<Message> messages = [];

    messages.add(
      Message("Hey Bro!", false)
    );
    messages.add(
        Message("Where?", false)
    );
    messages.add(
        Message("?", false)
    );
    messages.add(
        Message("?", false)
    );
    messages.add(
        Message("?", false)
    );
    messages.add(
        Message("Home", true)
    );
    messages.add(
        Message("And You?", true)
    );
    messages.add(
        Message("On the way!", false)
    );
    messages.add(
        Message("On Scene", true)
    );
    messages.add(
        Message("Come outside!", false)
    );
    messages.add(
        Message("Coming..", true)
    );
    return messages;
  }

}