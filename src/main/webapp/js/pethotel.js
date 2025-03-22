/* 
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/JavaScript.js to edit this template
 */


document.addEventListener("DOMContentLoaded", function () {
    // Xử lý bộ lọc
    const buttons = document.querySelectorAll('.nut-loc');
    const params = new URLSearchParams(window.location.search);
    const sizeFilter = params.get('sizeFilter') || 'all';
    const roomTypeFilter = params.get('roomTypeFilter') || 'all';

    buttons.forEach(button => {
        const buttonSize = button.getAttribute("onclick").match(/'([^']+)'/g)[0].replace(/'/g, "");
        const buttonType = button.getAttribute("onclick").match(/'([^']+)'/g)[1].replace(/'/g, "");

        if (buttonSize === sizeFilter && buttonType === roomTypeFilter) {
            button.classList.add('active');
        }

        button.addEventListener('click', function () {
            buttons.forEach(btn => btn.classList.remove('active'));
            this.classList.add('active');
        });
    });

    // Xử lý cuộn danh sách phòng
    const hotelList = document.querySelector(".hotel-list");
    const btnLeft = document.getElementById("scrollLeft");
    const btnRight = document.getElementById("scrollRight");
    const scrollAmount = 320;

    function checkScrollButtons() {
        btnLeft.style.display = hotelList.scrollLeft > 0 ? "block" : "block";
        btnRight.style.display = hotelList.scrollLeft < (hotelList.scrollWidth - hotelList.clientWidth) ? "block" : "block";
    }

    btnLeft.addEventListener("click", function () {
        hotelList.scrollBy({left: -scrollAmount, behavior: "smooth"});
    });

    btnRight.addEventListener("click", function () {
        hotelList.scrollBy({left: scrollAmount, behavior: "smooth"});
    });

    hotelList.addEventListener("scroll", checkScrollButtons);
    checkScrollButtons();

//    // Xử lý đặt phòng
//    const bookRoomBtns = document.querySelectorAll(".booking");
//
//    bookRoomBtns.forEach(button => {
//        button.addEventListener("click", function (event) {
//            event.preventDefault();
//            const roomStatus = button.getAttribute("data-status").trim().toLowerCase();
//
//            if (roomStatus === "hết phòng") {
//                Swal.fire({
//                    icon: 'error',
//                    title: 'Phòng đã hết!',
//                    text: 'Vui lòng chọn phòng khác. Xin cảm ơn!',
//                    confirmButtonText: 'OK',
//                    confirmButtonColor: '#8B4513'
//                });
//            } else {
//                window.location.href = button.getAttribute("href");
//            }
//        });
//    });

//    // Lưu vị trí cuộn trang
//    document.addEventListener("click", function (event) {
//        localStorage.setItem("scrollPosition", event.pageY);
//    });
//
//    // Cuộn về vị trí cũ khi load lại trang
//    let scrollPosition = localStorage.getItem("scrollPosition");
//    if (scrollPosition) {
//        window.scrollTo(0, scrollPosition);
//        localStorage.removeItem("scrollPosition");
//    }
});

// Hàm lọc phòng
function filterRooms(size, roomType) {
    window.location.href = "pethotel?sizeFilter=" + size + "&roomTypeFilter=" + roomType;
}
