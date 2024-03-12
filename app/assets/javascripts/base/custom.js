function replace_number(target_id) {
    var _number = $('#'+target_id).val();
    _number = _number
        .replace(/[０-９]/g, function (s) {
            return String.fromCharCode(s.charCodeAt(0) - 65248);
        }).replace(/[^0-9]/g, '');

    $('#'+target_id).val(_number);
};

$(document).ready(function() {
    set_select2()
});
function set_select2() {
    $('.select2').select2({
        closeOnSelect: true,
        dropdownAutoWidth:false,
        width: "resolve"
    });
};

function card_clear_js() {
    $(".delete_card_info").each(function(i, elem) {
        $(elem).val("");
    });

};

function loading_open() {
    $("#asnica-overlay").show();
};
function loading_close() {
    $("#asnica-overlay").hide();
};
