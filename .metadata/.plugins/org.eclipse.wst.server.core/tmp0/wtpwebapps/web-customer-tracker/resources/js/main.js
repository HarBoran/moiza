setInterval(createSnow, 100);
 
function createSnow() {
   const snow = document.createElement('div');
   snow.classList.add('snowflake');
   snow.style.left = '${Math.random() * window.screen.width}px'
   snow.style.animationDirection = Math.random() * 3 + 2 + 's';
   snow.style.opacity = Math.random();
   snow.style.fontSize = Math.random() * 10 + 10 + 'px';
 
   document.body.appendChild(snow);
 
   setTimeout(() => {
      snow.remove();
   }, 5000);
}

createSnow();

for(let index = 0; index < 50; index++){
	createSnow();
}
/*
function makeSnowflake() {
	const snowflake = document.createElement("div");
	const delay = Math.random() * 10;
	
	snowflake.classList.add("snowflake");
	snowflake.style.left = '${Math.random() * window.screen.width}px';
	snowflake.style.animationDelay = "${delay}s";
	body.appendChild(snowflake);
}


for(let index = 0; index < 50; index++){
	makeSnowflake();
}
*/