
class notification_model {
    String
    item_name,
        department;
    bool isSelected = false;
    bool changeColor = false;

    notification_model(this.changeColor,
        this.isSelected,
        this.item_name,
        this.department,);


}