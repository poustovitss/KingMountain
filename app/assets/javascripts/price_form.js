$(document).ready(function() {


    function change_total_price(price){
        var total_price = parseFloat($(".total_price-js").attr("data-price-food"));
        $(".total_price-js").text(total_price + price);
        $(".total_price-js").attr("data-price-food",total_price + price);
    }


    jQuery('.price_count_left').click(function() {
        var fieldToWork = jQuery(this).parent().find('#food_counter');
        var newValue = parseInt(fieldToWork.val()) - 1;
        var first_price = parseFloat(fieldToWork.data("price-food"));
        if (newValue > -1 ) {
            fieldToWork.val(newValue).trigger('change');
            change_total_price(first_price * -1);
        }
        return false;
    });
    jQuery('#food_counter').attr('readonly', 'readonly');

    // $('#food_counter').change(function(){
    //
    // });

    $(".start_price_extensions_item_check input").change(function(){
        var price = parseFloat($(this).data("price-add"));
        var b = $(this).is(":checked");
        if (b == true){
            change_total_price(price)
        }else{
            change_total_price(price * -1)
        }

    });

    jQuery('.price_count_right').on('click', function() {
        var fieldToWork = jQuery(this).parent().find('#food_counter');
        var newValue = parseInt(fieldToWork.val()) + 1;
        var first_price = parseFloat(fieldToWork.data("price-food"));
        if (newValue < 11 ) {
            fieldToWork.val(newValue).trigger('change');
            change_total_price(first_price);
        }
        return false;
    });
});