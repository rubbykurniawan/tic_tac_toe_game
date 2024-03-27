$(document).ready(function () {
    $("body").on("click", ".applyBoard", function () {
      var location = $(this).data('location');
      console.log("Clicked on location:", location);
      // Di sini Anda dapat menambahkan logika untuk menangani klik pada lokasi tertentu di papan permainan
    });
  });