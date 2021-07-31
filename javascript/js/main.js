// 사용변수
let score=0;

const wordInput = document.querySelector('.word-input');
const wordDisplay = document.querySelector('.word-display'); 

wordInput.addEventListener('input',  () => {
    console.log(wordInput.value.toLowerCase() === wordDisplay.innerText.toLowerCase());
});