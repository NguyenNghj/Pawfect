document.addEventListener('DOMContentLoaded', function () {
    const track = document.getElementById('reviewsTrack');
    const container = document.querySelector('.carousel-container');
    const items = document.querySelectorAll('.review-card');
    const prevBtn = document.getElementById('prevBtn');
    const nextBtn = document.getElementById('nextBtn');
    let currentPosition = 0;
    let cardWidth = items[0].offsetWidth + 30;
    let autoSlideInterval;
    let previousContainerWidth = container.offsetWidth;
    let isMouseOverCard = false;

    function updateSlider() {
        const offset = -currentPosition * cardWidth;
        track.style.transform = `translateX(${offset}px)`;
        prevBtn.disabled = currentPosition === 0;
        nextBtn.disabled = currentPosition >= Math.max(0, items.length - Math.floor(container.offsetWidth / cardWidth));
    }

    function startAutoSlide() {
        autoSlideInterval = setInterval(() => {
            const visibleCards = Math.floor(container.offsetWidth / cardWidth);
            const maxPosition = Math.max(0, items.length - visibleCards);
            if (currentPosition < maxPosition) {
                currentPosition++;
            } else {
                currentPosition = 0;
            }
            updateSlider();
        }, 4000);
    }

    function stopAutoSlide() {
        clearInterval(autoSlideInterval);
    }

    nextBtn.addEventListener('click', () => {
        const visibleCards = Math.floor(container.offsetWidth / cardWidth);
        const maxPosition = Math.max(0, items.length - visibleCards);
        if (currentPosition < maxPosition) {
            currentPosition++;
            updateSlider();
        }
    });

    prevBtn.addEventListener('click', () => {
        if (currentPosition > 0) {
            currentPosition--;
            updateSlider();
        }
    });

    items.forEach(card => {
        card.addEventListener('mouseenter', () => {
            if (!isMouseOverCard) {
                stopAutoSlide();
                isMouseOverCard = true;
            }
        });

        card.addEventListener('mouseleave', () => {
            if (isMouseOverCard) {
                startAutoSlide();
                isMouseOverCard = false;
            }
        });

        const readMoreBtn = card.querySelector('.read-more-btn');
        const reviewText = card.querySelector('.review-text');
        const staffText = card.querySelector('.staff-text');

        const isContentShort = (!staffText && reviewText.scrollHeight <= reviewText.clientHeight) ||
            (staffText && reviewText.scrollHeight <= reviewText.clientHeight &&
                staffText.scrollHeight <= staffText.clientHeight);

        if (isContentShort) {
            readMoreBtn.style.display = 'none';
            return;
        }

        readMoreBtn.addEventListener('click', () => {
            const btnText = readMoreBtn.querySelector('.btn-text');
            const icon = readMoreBtn.querySelector('i');

            card.classList.toggle('collapsed');

            if (card.classList.contains('collapsed')) {
                btnText.textContent = 'Đọc thêm';
                icon.classList.replace('fa-chevron-up', 'fa-chevron-down');
                if (!isMouseOverCard) {
                    startAutoSlide();
                }
            } else {
                btnText.textContent = 'Thu gọn';
                icon.classList.replace('fa-chevron-down', 'fa-chevron-up');
                if (!isMouseOverCard) {
                    stopAutoSlide();
                }
            }
        });
    });

    window.addEventListener('resize', () => {
        if (Math.abs(container.offsetWidth - previousContainerWidth) > 50) {
            previousContainerWidth = container.offsetWidth;
            cardWidth = items[0].offsetWidth + 30;
            const newVisibleCards = Math.floor(container.offsetWidth / cardWidth);
            const newMaxPosition = Math.max(0, items.length - newVisibleCards);
            currentPosition = Math.min(currentPosition, newMaxPosition);
            updateSlider();
        }
    });

    window.onbeforeunload = () => {
        stopAutoSlide();
    };

    updateSlider();
    startAutoSlide();
});