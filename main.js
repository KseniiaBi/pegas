let accordeons = document.querySelectorAll('.accordeon_item');
let mainImg = document.querySelector('.main_img img');
let showbookModal = document.querySelector('#showbook');
let callBackBtn = document.querySelector('.callback');
let callbackModal = document.querySelector('#call_me');
let filterbtn = document.querySelector('.showfilters');
let closeFilterBtn = document.querySelector('.closefilters');
let filters = document.querySelector('.filter_bar');
let detailsCol1 = document.querySelector('#det_col1');
let detailsCol2 = document.querySelector('#det_col2');
let det_prevbtn = document.querySelector('.dc_prev');
let det_nextbtn = document.querySelector('.dc_next');


if(filters){
	filterbtn.onclick = () => filters.classList.add('opened');
	closeFilterBtn.onclick = () => filters.classList.remove('opened');
}


callBackBtn.onclick = () => callbackModal.style.display = 'flex';

document.addEventListener('click', function(e){
	if(e.target.classList.contains('dc_prev') && !e.target.classList.contains('inactive')){
		detailsCol1.style.display = 'block';
		detailsCol2.style.display = 'none';
		det_nextbtn.classList.remove('inactive');
		det_prevbtn.classList.add('inactive');
	}
	if(e.target.classList.contains('dc_next') && !e.target.classList.contains('inactive')){
		detailsCol2.style.display = 'block';
		detailsCol1.style.display = 'none';
		det_nextbtn.classList.add('inactive');
		det_prevbtn.classList.remove('inactive');
	}
	if(e.target.classList.contains('accordeon_title')){
		if(e.target.parentNode.classList.contains('opened')){
			e.target.parentNode.classList.remove('opened');
		}
		else{	
			for(let i = 0; i < accordeons.length; i++){
				accordeons[i].classList.remove('opened');
			}
			e.target.parentNode.classList.add('opened');
		}
	}
	if(e.target.classList.contains('book_miniature')){
		mainImg.src = e.target.src;
	}

	// toggle visibility of filter group
	if(e.target.classList.contains('filter_title')){
		e.target.classList.toggle('expanded');
	}
	// book show preview
	if(e.target.classList.contains('book_show_preview')){
		let bookInner = e.target.parentNode.parentNode.parentNode.parentNode.cloneNode(true);
		bookInner.classList.add('opened_preview');
		bookInner.classList.add('book_view');
		showbookModal.innerHTML = '';
		showbookModal.append(bookInner);
		showbookModal.style.display = 'flex';
	}	
	// close modal
	if(e.target.classList.contains('closebtn')){
		e.target.parentNode.parentNode.style.display = 'none';
	}
	//  selectbox
	if(e.target.classList.contains('val_selected')){
		if(e.target.parentNode.classList.contains('expanded')){
			e.target.parentNode.classList.remove('expanded');
		}
		else{
			e.target.parentNode.classList.add('expanded');
		}
	}
	if(e.target.classList.contains('sel_option')){
		e.target.parentNode.parentNode.classList.remove('expanded');
		let selected = e.target.parentNode.parentNode.querySelector('.val_selected');
		selected.innerText = e.target.innerText;
	}
	
});

// price slider drag-n-drop

let price_range = document.querySelector('#sel_pricerange');
if(price_range){
	let startNum = price_range.querySelector('.start_sum');
	let startBullet = price_range.querySelector('.start_price');
	let startAmount = +startNum.innerText;
	let endNum = price_range.querySelector('.end_sum');
	let endBullet = price_range.querySelector('.end_price');
	let endAmount = +endNum.innerText;
	let bar = price_range.querySelector('.price_bar');
	let bar_width = bar.offsetWidth  - endBullet.offsetWidth;

	function moveThumb(event, el) {
	  event.preventDefault(); // prevent selection start (browser action)

	  let shiftX = event.clientX - el.getBoundingClientRect().left;
	  // shiftY not needed, the thumb moves only horizontally

	  document.addEventListener('mousemove', onMouseMove);
	  document.addEventListener('mouseup', onMouseUp);

	  function onMouseMove(event) {
	    let newLeft = event.clientX - shiftX - bar.getBoundingClientRect().left;

	    let neib = el == endBullet ? startBullet : endBullet;
	    let neibLeft = window.getComputedStyle(neib).getPropertyValue('left');
	    neibLeft = neibLeft.substr(0, neibLeft.length - 2);
	    // the pointer is out of slider => lock the thumb within the bounaries
	    if (newLeft < 0) {
	      newLeft = 0;
	    }

	    let rightEdge = bar_width;
	    if (newLeft > rightEdge ) {
	      newLeft = rightEdge;
	    }

	    if(el == endBullet && newLeft < neibLeft || el == startBullet && newLeft > neibLeft){
			newLeft = neibLeft;
	    }

	    let price = +price_range.dataset.max;
	    let priceSpan = el == endBullet ? endNum : startNum;

	    priceSpan.innerText = Math.floor(price*(newLeft )/bar_width);

	    el.style.left = newLeft + 'px';
	  }

	  function onMouseUp() {
	    document.removeEventListener('mouseup', onMouseUp);
	    document.removeEventListener('mousemove', onMouseMove);
	  }

	};

	startBullet.onmousedown = () => moveThumb(event, startBullet);
	endBullet.onmousedown = () => moveThumb(event, endBullet);

	endBullet.ondragstart = function() {
	  return false;
	};

	startBullet.ondragstart = function() {
	  return false;
	};

}

// books age filter carousel

let ages_prev = document.querySelector('.sc_prev');
let ages_next = document.querySelector('.sc_next');
let ages_wrap = document.querySelector('.select_carousel_wrap');
let ages_carousel = document.querySelector('.select_carousel_content');
let age_items = document.querySelectorAll('.sc_item');

if(ages_prev){
	let showingAges = Math.floor(ages_wrap.offsetWidth / age_items[0].offsetWidth);
	let ages_margin = window.getComputedStyle(age_items[0]).getPropertyValue('margin-right');
	ages_margin = +ages_margin.substr(0, ages_margin.length-2);
	let ages_transform = age_items[0].offsetWidth  + ages_margin;

	ages_prev.onclick = ages_showprev;
	ages_next.onclick = ages_shownext;

	let currentAgesTr = 0;
	let showingLastAge = false;
	let showingFirstAge = true;

	function checkAgeArrows(){
		if(currentAgesTr == -1*ages_transform*(age_items.length-showingAges)){
			showingLastAge = true;
			showingFirstAge = false;
			ages_next.classList.add('inactive');
			ages_prev.classList.remove('inactive');
		}
		else if(currentAgesTr == 0){
			showingLastAge = false;
			showingFirstAge = true;
			ages_prev.classList.add('inactive');
			ages_next.classList.remove('inactive');
		}
		else{
			showingLastAge = false;
			showingFirstAge = false;
			ages_next.classList.remove('inactive');
			ages_prev.classList.remove('inactive');
		}
	}

	function ages_shownext(){
		if(!showingLastAge){
			currentAgesTr -= ages_transform;
			ages_carousel.style.transform = `translateX(${currentAgesTr}px)`;
			checkAgeArrows();
		}
	}

	function ages_showprev(){
		if(!showingFirstAge){
			currentAgesTr += ages_transform;
			ages_carousel.style.transform = `translateX(${currentAgesTr}px)`;
			checkAgeArrows();
		}
	}
}


// main page books carousel + mask

class Carousel{
	constructor(elem){
		this.node = elem;
		this.wrap = elem.querySelector('.books_wrap');
		this.btn_prev = elem.querySelector('.books_prev');
		this.btn_next = elem.querySelector('.books_next');
		this.items = document.querySelectorAll('.book_item');
		let book_margin = window.getComputedStyle(this.items[0]).getPropertyValue('margin-right');
		this.book_margin = +book_margin.substr(0, book_margin.length-2);
		this.targetTransform = this.items[0].offsetWidth  + this.book_margin;
		this.currentTransform = 0;
		this.showingLastBook = false;
		this.showingFirstBook = true;
		this.booksInView = Math.ceil(document.body.offsetWidth / this.targetTransform);

		this.btn_prev.onclick = () => this.moveBook('prev');
		this.btn_next.onclick = () => this.moveBook('next');
	}

	checkBookArrows(){
		if(this.currentTransform == -1*this.targetTransform*this.booksInView){
			this.showingLastBook = true;
			this.showingFirstBook = false;
			this.btn_next.classList.add('invisible');
			this.btn_prev.classList.remove('invisible');
		}
		else if(this.currentTransform == 0){
			this.showingLastBook = false;
			this.showingFirstBook = true;
			this.btn_prev.classList.add('invisible');
			this.btn_next.classList.remove('invisible');
		}
		else{
			this.showingLastBook = false;
			this.showingFirstBook = false;
			this.btn_next.classList.remove('invisible');
			this.btn_prev.classList.remove('invisible');
		}
	}

	moveBook(direction){
		if(direction == 'next'){
			if(!this.showingLastBook){
				this.currentTransform -= this.targetTransform;
			}
		}
		else{
			if(!this.showingFirstBook){
				this.currentTransform += this.targetTransform;
			}
		}
		this.wrap.style.transform = `translateX(${this.currentTransform}px)`;
		
		this.checkBookArrows();
	}

}

let book_carousels = document.querySelectorAll('.book_carousel');

if(book_carousels.length > 0){
	for(let i = 0; i < book_carousels.length; i++){
		let c = new Carousel(book_carousels[i]);
	}
}


// attach book filters + redirection


// book card carousel
let prev_prev_btn = document.querySelector('.miniatures_prev');
let prev_next_btn = document.querySelector('.miniatures_next');
let miniatures_wrap = document.querySelector('.book_preview_wrap');
let miniatures = document.querySelectorAll('.book_miniature');

if(miniatures_wrap){
	let miniature_margin = window.getComputedStyle(miniatures[0]).getPropertyValue('margin-right');
	miniature_margin =	miniature_margin.substr(0, miniature_margin.length-2);
	let target_move = miniatures[0].offsetWidth + Number(miniature_margin);

	document.addEventListener('click', function(){
		if(event.target.classList.contains('miniatures_prev')){
			previews_prev();
		}
		if(event.target.classList.contains('miniatures_next')){
			previews_next();
		}
	});

	function previews_next(){
		miniatures_wrap.style.transform = `translateX(-${target_move}px)`;	
		miniatures_wrap.style.transform = 0;
		miniatures_wrap.lastElementChild.after(miniatures_wrap.firstElementChild);
	}

	function previews_prev(){
		miniatures_wrap.firstElementChild.before(miniatures_wrap.lastElementChild);
		miniatures_wrap.style.transform = `translateX(-${target_move}px)`;
		miniatures_wrap.style.transform = `translateX(${0}px)`;
	}

}

// tabs

class Tabs{
	constructor(parent, tab_id){
		this.parent = parent;
		this.tabBtns = document.querySelectorAll(`.tab_name.${tab_id}`);
		this.tabContent = document.querySelectorAll(`.tab.${tab_id}`);
		this.chooseTab = this.chooseTab.bind(this);

		for(let i = 0; i < this.tabBtns.length; i++){
			this.tabBtns[i].onclick = (e) => {
				let id = e.target.dataset.id;
				this.chooseTab(id,e.target);
			}
		}
	}

	chooseTab(id,el){
		for(let i = 0; i < this.tabBtns.length; i++){
			this.tabBtns[i].classList.remove('active');
			this.tabContent[i].classList.remove('active');
		}
		el.classList.add('active');
		document.getElementById(id).classList.add('active');
	}
}


let tabs = document.querySelectorAll('.tabs');

if(tabs.length > 0){
	for(let i = 0; i < tabs.length; i++){
		let tabId = tabs[i].dataset.id;
		let t = new Tabs(tabs[i],tabId);
		console.log(t);
	}
}