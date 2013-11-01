$(function() {
	console.log("Javascript!");

	$("#add-bill").click(function(e) {
		e.preventDefault();
		if ($("#bill-name").val() == "") {
			alert("Name of bill cannot be blank.");
		} else {
			submitBill();
		}
	});

	var submitBill = function() {
		var bill = $.post("/bills.json", {bill: {name: 'abc', amount: 10} });
		bill.done(function(data) {

			$("#form-submit-messages").text(data.message);
		});
	};
});