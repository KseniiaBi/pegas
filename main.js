let accordeons = document.querySelectorAll('.accordeon_item');
let mainImg = document.querySelector('.main_img img');
let showbookModal = document.querySelector('#showbook');
let callBackBtn = document.querySelector('.callback');
let callbackModal = document.querySelector('#re-call-modal');
let filterbtn = document.querySelector('.showfilters');
let closeFilterBtn = document.querySelector('.closefilters');
let filters = document.querySelector('.filter_bar');
let detailsCol1 = document.querySelector('#det_col1');
let detailsCol2 = document.querySelector('#det_col2');
let det_prevbtn = document.querySelector('.dc_prev');
let det_nextbtn = document.querySelector('.dc_next');
let menubtn =  document.querySelector('.menubtn');
let header = document.querySelector('header');
let search_btn = document.querySelector('.search_icon_btn');
let search_field = document.querySelector('.sitesearch');
let isShowingSearch = false;
let ageFilterStr = '';
let genderfilterStr = '';
let priceFilter = ''; 
let header_acc_submenu = document.querySelector('.top_acc');
let header_acc_btn = document.querySelector('.top_acc .has_inner');



if(header_acc_btn != null){
	header_acc_btn.onclick = () => header_acc_submenu.classList.toggle('opened');
}

if((screen.width < 768 || window.innerWidth < 768) && search_btn != null){
	search_btn.onclick = () => search_field.classList.toggle('opened');
	search_field.onkeyup = (e) => {
		if(e.keyCode == 13){
			search_field.classList.remove('opened');
		} 
	}
}
search_field.onsubmit = () => search_field.classList.remove('opened');

menubtn.onclick = () => header.classList.toggle('opened');

if(filters){
	filterbtn.onclick = () => filters.classList.add('opened');
	closeFilterBtn.onclick = () => filters.classList.remove('opened');
}

callBackBtn.onclick = () => callbackModal.style.display = 'flex';

let createURL = () => {
	let url = window.location.origin + '/literature-catalog';

	if(ageFilterStr.length > 0){
	 url += `/${ageFilterStr}/`;
	}
	if(genderfilterStr.length > 0){
	 url += `${genderfilterStr}/`;
	}

	if(priceFilter.length > 0){
		url += priceFilter;
	}
	console.log(url);
	window.location.href = url;
}


document.addEventListener('click', function(e){

	if(e.target.classList.contains('showpass')){
		e.target.parentNode.querySelector('input').setAttribute('type', 'text');
	}

	if(e.target.classList.contains('close') ){
		e.target.parentNode.style.display = 'none';
	}

	if(e.target.classList.contains('dc_prev') && !e.target.classList.contains('inactive')){
		detailsCol1.style.display = 'table';
		detailsCol2.style.display = 'none';
		det_nextbtn.classList.remove('inactive');
		det_prevbtn.classList.add('inactive');
	}
	if(e.target.classList.contains('dc_next') && !e.target.classList.contains('inactive')){
		detailsCol2.style.display = 'table';
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
		if(screen.width < 600 || window.innerWidth < 600){
			showBigBookPicture(e.target);
		}
		else{
			let mainImg = e.target.parentNode.parentNode.parentNode.parentNode.querySelector('.main_img img');
			mainImg.src = e.target.getAttribute('src');
		}	
	}

	// toggle visibility of filter group markup
	if(e.target.classList.contains('filter_title')){
		e.target.classList.toggle('expanded');
	}
	// toggle visibility of filter group production
	if(e.target.classList.contains('title_filter')){
		e.target.classList.toggle('collapsed');
	}
	// book show preview
	if(e.target.classList.contains('book_show_preview')){
		let bookID = +e.target.dataset.id;
		let bookData = `http://test.pegas.ua/index.php?route=product/product/preview&preview_id=${bookID}`;
		// let bookData = 'sample.json';

		let promise = fetch(bookData);
		promise.then((resp)=> resp.json())
				.then((r) => {
					data = r;
					createBookPreview(r);
				});
	}	
	// close modal
	if(e.target.classList.contains('closebtn')){
		
		if(e.target.parentNode.classList.contains('opened_preview')){
			showbookModal.style.display = 'none';
			e.target.parentNode.classList.remove('opened_preview');
			e.target.parentNode.classList.remove('book_view');
		}
		else{
			e.target.parentNode.parentNode.style.display = 'none';
		}
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
		
		if(e.target.parentNode.parentNode.id == 'sel_age'){
			ageFilterStr = ageFilterStr.length == 0 ?  ageFilterStr += e.target.dataset.value : ageFilterStr += '~' + e.target.dataset.value;
		}	
		if(e.target.parentNode.parentNode.id == 'sel_gender'){
			// genderfilterStr = genderfilterStr.length == 0 ?  genderfilterStr += e.target.dataset.value : genderfilterStr += '~' + e.target.dataset.value;
			genderfilterStr =  e.target.dataset.value;
		}
	}
	if(e.target.id == 'sel_book_btn'){
		createURL();
	}
	if(e.target.classList.contains('fade') ){
		filters.classList.remove('opened');
	}
	if(e.target.parentNode.classList.contains('main_img') &&
		e.target.parentNode.parentNode.parentNode.classList.contains('book_view')){
		showBigBookPicture(e.target);
	}
	if(e.target.classList.contains('pic_prev')){
		showPrevPic();
	}
	if(e.target.classList.contains('pic_next')){
		showNextPic();
	}
});

// create book preview

const catalogURL = '';

function createBookPreview(data){
	console.log(data);
	let wrap = document.createElement('div');
	wrap.classList.add('book_inner','opened_preview','book_view');

	let closebtn = document.createElement('div');
	closebtn.classList.add('closebtn');

	let preview = document.createElement('div');
	preview.classList.add('book_preview');
	

	let mainImg = document.createElement('div');
	mainImg.classList.add('main_img');
	let bigPic = new Image();
	bigPic.src = data.images[0].thumb;
	bigPic.dataset.bigimage = data.images[0].popup; // big image for preview
	bigPic.alt = '';
	mainImg.append(bigPic);
	preview.append(mainImg);

	let carousel = document.createElement('div');
	carousel.classList.add('book_pictures', 'carousel');

	let arr_prev = document.createElement('div');
	arr_prev.classList.add('miniatures_prev', 'btn_prev');

	let arr_next = document.createElement('div');
	arr_next.classList.add('miniatures_next', 'btn_next');

	let car_outer = document.createElement('div');
	car_outer.classList.add('book_carousel_outer');

	let preview_wrap = document.createElement('div');
	preview_wrap.classList.add('book_preview_wrap');

	if(data.images.length > 0){
		for(let min of data.images){
			let miniImg = new Image();
			miniImg.src = min.thumb;
			miniImg.dataset.bigimage = min.popup;
			miniImg.classList.add('book_miniature');
			miniImg.alt = data.heading_title;
	
			preview_wrap.append(miniImg);
		}
	}
	car_outer.append(preview_wrap);
	carousel.append(arr_prev, car_outer, arr_next);
	preview.append(carousel);

	let info = document.createElement('div');
	info.classList.add('book_info');

	let bookname = document.createElement('h4');
	bookname.innerText = data.heading_title;

	let rating = document.createElement('div');
	rating.classList.add('rating');

	for(let i = 0; i < 5; i++){
		let star = document.createElement('div');
		star.classList.add('star');
		if(i+1 < data.rating){
			star.classList.add('filled');
		}
		else{
			star.classList.add('not_filled');
		}
		rating.append(star);
	}

	let price = document.createElement('div');
	price.classList.add('price');
	if(data.akchia){
		let new_price;
		let old_price = data.price;
		if (typeof data.special != 'boolean') {
			 new_price = data.special;
		} else {
			 new_price = data.price;
		}

		price.classList.add('sale');
		price.innerHTML = `<span class="prop_name">${data.text_price_c}</span>
		<div class="price_new">${new_price} ${data.text_currency}</div>
		<div class="price_old">
			<div class="full_price"><span class="line_trough">${old_price}${data.text_currency}</span> </div>
			<div class="disc_amount">${data.text_akchia} ${data.discount_percent}%</div>
		</div>`;
	}
	else{
		price.innerHTML = `<span class="prop_name">${data.text_price_c}</span>${data.price}${data.text_currency}`;
	}

	let booklang = document.createElement('div');
	booklang.classList.add('book_lang');
	for(let i = 0; i < data.other_lang.length; i++){
		let lang = document.createElement('a');
		lang.classList.add('book_lang_item');
		if(data.other_lang[i].active === true){
			lang.classList.add('active');
		}
		lang.href = data.other_lang[i].href;
		lang.innerText = data.other_lang[i].name;
		booklang.append(lang);
	}

	let bookseries = document.createElement('div');
	bookseries.classList.add('book_series');
	bookseries.innerText = data.serries;

	let isbn = document.createElement('div');
	isbn.classList.add('isbn');
	isbn.innerHTML = `<span class="prop_name">ISBN</span> ${data.isbn}`;

	let avail = document.createElement('div');
	availClass = +data.stock_count > 0 ? 'instock' : 'outofstock';
	avail.classList.add('available', availClass);
	avail.innerText = data.stock;

	let actions = document.createElement('div');
	actions.classList.add('book_actions');
	actions.innerHTML = `<div class="buy btn btn_grad">${data.button_cart}  <img src="catalog/view/theme/THEME/img/cart.svg" alt="${data.button_cart}"></div>
	<div class="btn btn_bordered like"><img src="catalog/view/theme/THEME/img/heart_grad.svg" alt=""></div>`;

	let fulldescr = document.createElement('p');
	fulldescr.classList.add('book_fulldescr');
	fulldescr.innerHTML = data.description;

	let prodBtn = document.createElement('a');
	prodBtn.href = data.other_lang[0].href;
	prodBtn.classList.add('btn','btn_bordered');
	prodBtn.innerHTML = `<span>${data.text_preview}</span> `;
	

	info.append(bookname, rating, price, booklang, actions, bookseries, isbn, avail, fulldescr, prodBtn);
	
	wrap.append(closebtn, preview, info);
	showbookModal.innerHTML = '';
	showbookModal.append(wrap);
	showbookModal.style.display = 'flex';

	if(data.images.length > 0){
		let previewCar = new MiniaturesCarousel(preview_wrap);
	}
	
}

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

	let priceValStart = startAmount;
	let priceValEnd = endAmount;

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
	    let priceSpan;
	    let priceNum = Math.floor(price*(newLeft )/bar_width);

	    if(el == endBullet){
			priceSpan = endNum;
			priceValEnd = priceNum;
	    }
	    else{
	    	priceSpan = startNum;
	    	priceValStart = priceNum;
	    }
	    
	    priceSpan.innerText = priceNum;
	    targetFilter = priceNum;
	    el.style.left = newLeft + 'px';
	    priceFilter =  `?prs[1]=${priceValStart}.00-${priceValEnd}.00`;
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

class MiniaturesCarousel{
	constructor(wrap){
		this.parent = wrap;
		this.prev_btn = this.parent.parentNode.parentNode.querySelector('.miniatures_prev');
		this.next_btn = this.parent.parentNode.parentNode.querySelector('.miniatures_next');
		this.miniatures = this.parent.querySelectorAll('.book_miniature');
		this.miniature_margin = window.getComputedStyle(this.miniatures[0]).getPropertyValue('margin-right');
		this.miniature_margin =	this.miniature_margin.substr(0, this.miniature_margin.length-2);
		this.target_move = this.miniatures[0].offsetWidth + Number(this.miniature_margin);
		this.minsInView = Math.ceil(this.parent.offsetWidth / this.target_move);
		this.currentMinTr = 0;

		this.prev_btn.onclick =  this.previews_prev.bind(this);
		this.next_btn.onclick =  this.previews_next.bind(this);
		
		this.showingLastMiniature = false;
		this.showingFirstMiniature = true;
		this.checkArrows();
	}


	checkArrows(){
		if(this.miniatures.length <= 2){
			this.showingLastMiniature = true;
			this.next_btn.classList.add('inactive');
			this.prev_btn.classList.add('inactive');
			return;
		}
		if(this.currentMinTr == -1*this.target_move*this.minsInView){
			this.showingLastMiniature = true;
			this.showingFirstMiniature = false;
			this.next_btn.classList.add('inactive');
			this.prev_btn.classList.remove('inactive');
		}
		else if(this.currentMinTr == 0){
			this.showingLastMiniature = false;
			this.showingFirstMiniature = true;
			this.prev_btn.classList.add('inactive');
			this.next_btn.classList.remove('inactive');
		}
		else{
			this.showingLastMiniature = false;
			this.showingFirstMiniature = false;
			this.next_btn.classList.remove('inactive');
			this.prev_btn.classList.remove('inactive');
		}
	}

	previews_next(){
		if(!this.showingLastMiniature){
			this.currentMinTr -= this.target_move;
			this.parent.style.transform = `translateX(${this.currentMinTr}px)`;	
			this.checkArrows();
		}
		
	}

	previews_prev(){
		if(!this.showingFirstMiniature){
			this.currentMinTr += this.target_move;
			this.parent.style.transform = `translateX(${this.currentMinTr}px)`;
			this.checkArrows();
		}
		
	}
}

let miniatures_wrap = document.querySelectorAll('.book_view .book_preview_wrap');

if(miniatures_wrap.length > 0){
	for(let i = 0; i < miniatures_wrap.length; i++){
		let mc = new MiniaturesCarousel(miniatures_wrap[i]);
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
	}
}

// top menu show active link
window.onload = () => {
	setActiveTopLink();
	if(screen.width < 600 || window.innerWidth < 600){
		let menu = document.querySelector('ul.menu');
		setActiveMenuLink();
		let currLink = menu.querySelector('.menuitem.active');
		let currLinkWidth = window.getComputedStyle(currLink).width;
		currLinkWidth = Math.floor(Number(currLinkWidth.substr(0,currLinkWidth.length-2)));
		let maxOffset = document.body.offsetWidth;

		let linkOffset = currLink.offsetLeft;
		if(linkOffset + currLinkWidth > maxOffset){
			linkOffset = maxOffset + 45;
		}
		menu.scrollLeft = linkOffset - 14;
	}

	let sorted = document.querySelectorAll('.sel_option');
	if(sorted.length > 0){
		for(let opt of sorted){
			if(window.location.href == opt.href){
				opt.dataset.selected = 'true';
				let selectedOpt = opt.parentNode.parentNode.querySelector('.val_selected');
				selectedOpt.innerText = opt.innerText;
			}
		}
	}
}

function setActiveTopLink(){
	let currentURL = window.location.href;
	let topMenuLinks = document.querySelectorAll('.topnav .h_top_link');
	
	for(let link of topMenuLinks){
		link.classList.remove('active');
	}

	if(currentURL.includes('vydavnychyi-dim-pehas')){
		topMenuLinks[0].classList.add('active');
	}
	else if(currentURL.includes('pegas-articles')){
		// акции
		topMenuLinks[1].classList.add('active');
	}
	else if(currentURL.includes('dropshipping')){
		// новинки
		topMenuLinks[2].classList.add('active');
	}
	else if(currentURL.includes('dostavka-i-oplata')){
		// подарки
		topMenuLinks[3].classList.add('active');
	}
	else if(currentURL.includes('contacts')){
		// развлечения
		topMenuLinks[4].classList.add('active');
	}
}


function setActiveMenuLink(){
	let currentURL = window.location.href;
	let bottomMenuLinks = document.querySelectorAll('ul.menu .menuitem');
	
	for(let link of bottomMenuLinks){
		link.classList.remove('active');
	}

	if(currentURL.includes('literature-catalog')){
		bottomMenuLinks[1].classList.add('active');
	}
	else if(currentURL.includes('aktsiia')){
		// акции
		bottomMenuLinks[2].classList.add('active');
	}
	else if(currentURL.includes('novelty')){
		// новинки
		bottomMenuLinks[3].classList.add('active');
	}
	else if(currentURL.includes('kazka-na-nich')){
		// подарки
		bottomMenuLinks[4].classList.add('active');
	}
	else if(currentURL.includes('spilni-zakupivli')){
		// развлечения
		bottomMenuLinks[5].classList.add('active');
	}
	else{
		bottomMenuLinks[0].classList.add('active');
	}
}

	
// reviews

let leaveRevBtns = document.querySelectorAll('.leave_rev');
let leaveRevModal = document.querySelector('#leave_rev_md');
let showRevMdBtn = document.querySelectorAll('.show_rev_md');
let showRevMd = document.querySelector('#book_for_review');

if(showRevMd != null){
	for(let btn of showRevMdBtn){
		btn.onclick = () => addBooksForReview(btn.parentNode.parentNode);
	}
}

function addBooksForReview(order){
	let orderedBooks = order.querySelectorAll('.order_item');
	let mdContent = showRevMd.querySelector('.modal_content main');
	mdContent.innerHTML = '';
	for(let book of orderedBooks){
		let clone = book.cloneNode(true);
		clone.querySelector('.order_book_sum').remove();
		let lrBtn = document.createElement('button');
		lrBtn.innerHTML = `<span>Оставить отзыв</span>`;
		lrBtn.classList.add('btn_bordered', 'btn', 'leave_rev');
		lrBtn.dataset.id = book.dataset.id;
		lrBtn.onclick = (event) => {
			// reviewedID = 0; !!!!!
			leaveRevModal.style.display = 'flex';
			leaveRevModal.querySelector('#button-review').dataset.id = event.target.dataset.id;
		}
		clone.querySelector('.order_book_info').append(lrBtn);
		mdContent.append(clone);
	}
	showRevMd.style.display = 'flex';
}


if(leaveRevModal != null){

	for(let btn of leaveRevBtns){
		btn.onclick = () => leaveRevModal.style.display = 'flex';
	}
	
	let closeRevMdBtn = leaveRevModal.querySelector('.btn_bordered');
	closeRevMdBtn.onclick = () => leaveRevModal.style.display = 'none';


	// закрашивание звезд
	let rev_stars = leaveRevModal.querySelectorAll('.rev_star');

	for(let i = 0; i < rev_stars.length; i++){
		rev_stars[i].onclick = () => {
			ratingNum = i+1;
			let starnum = i;
			for(let j = 0; j < rev_stars.length; j++){
				let st = rev_stars[j].querySelector('.star');
					st.classList.add('not_filled');
				if(j <= i){
					st.classList.remove('not_filled');
					st.classList.add('filled');

				}			
			}
			// ratingEl.value = ratingNum;
		}
	}
}

function initReviews(){
	let rev_car = document.querySelector('.rev_carousel');
	let reviews = document.querySelectorAll('.review_item');
	let showMoreRevsBtn = document.querySelector('.view_all_rev');
	let visibleAllRevs = false;
	if(reviews.length > 1){	
		// show all reviews
		let btn_txt = showMoreRevsBtn.querySelector('span').innerText;
		showMoreRevsBtn.onclick = () => {
			rev_car.classList.toggle('show_all');
			if(!visibleAllRevs){
				showMoreRevsBtn.querySelector('span').innerText = 'По одному';
			}
			else{
				showMoreRevsBtn.querySelector('span').innerText = btn_txt;
			}
			visibleAllRevs = !visibleAllRevs;
		}
		
		// карусель

		let reviews_prev = document.querySelector('.rev_prev');
		let reviews_next = document.querySelector('.rev_next');
		let reviews_wrap = document.querySelector('.rev_content');

		let showingReviews = 1;
		let reviews_transform = reviews[0].offsetWidth;

		reviews_prev.onclick = reviews_showprev;
		reviews_next.onclick = reviews_shownext;

		let currentRevTr = 0;
		let showingLastRev = false;
		let showingFirstRev = true;

		checkRevArrows();

		function checkRevArrows(){
			if(currentRevTr == -1*reviews_transform*(reviews.length-showingReviews)){
				showingLastRev = true;
				showingFirstRev = false;
				reviews_next.classList.add('inactive');
				reviews_prev.classList.remove('inactive');
			}
			else if(currentRevTr == 0){
				showingLastRev = false;
				showingFirstRev = true;
				reviews_prev.classList.add('inactive');
				reviews_next.classList.remove('inactive');
			}
			else{
				showingLastRev = false;
				showingFirstRev = false;
				reviews_next.classList.remove('inactive');
				reviews_prev.classList.remove('inactive');
			}
		}

		function reviews_shownext(){
			if(!showingLastRev){
				currentRevTr -= reviews_transform;
				reviews_wrap.style.transform = `translateX(${currentRevTr}px)`;
				checkRevArrows();
			}
		}

		function reviews_showprev(){
			if(!showingFirstRev){
				currentRevTr += reviews_transform;
				reviews_wrap.style.transform = `translateX(${currentRevTr}px)`;
				checkRevArrows();
			}
		}

	}
}

setTimeout(initReviews, 2000);

// saved books filters

const filterbar = document.querySelector('.user_space .filter_bar');

if(filterbar != null){
	document.addEventListener('click', function(e){
		if(e.target.classList.contains('sel_option')){
			filterbar.classList.remove('opened');
		}
	});
}


// cart promocode scroll

let cart_items = document.querySelectorAll('.cart_item');

if(window.innerWidth > 1014 && cart_items.length > 2){
	let promos = document.querySelector('.cart_promos');
	let cart = document.querySelector('.cart_content');
	let cartHeight = cart.offsetHeight;
	console.log(cartHeight);
	let parent = document.querySelector('.cart_inner');

	let promos_offset = promos.offsetTop + parent.offsetTop + 100;
	let promos_fixed = false;
	window.onscroll = () => {

		if(window.scrollY > promos_offset && window.scrollY < (promos_offset + cartHeight) && !promos_fixed){
			promos_fixed = true;
			promos.classList.add('fixed');
		}
		if((window.scrollY < promos_offset || window.scrollY > (cartHeight+ promos_offset - 200))  && promos_fixed){
			promos_fixed = false;
			promos.classList.remove('fixed');
		}
	}
}


// banner-slider


let slides = document.querySelectorAll('.slide');
let sliderDots = document.querySelectorAll('.sl_dot');
let currentSlide = 0;
let slider = document.querySelector('.slider');
let slideRinterval;


if(slides.length >0){
	sliderDots[0].classList.add('active');
	slides[0].classList.add('active');
	for(let i = 0; i < sliderDots.length; i++){
		sliderDots[i].dataset.slide = i;
		sliderDots[i].onclick = (e) => {
			clearInterval(slideRinterval);
			currentSlide = +e.target.dataset.slide;
			changeSlide(currentSlide);
		}	
	}

	slider.addEventListener('touchstart', handleTouchStart, false);        
	slider.addEventListener('touchmove', handleTouchMove, false);

	initSlider();
}

function initSlider(){
	slideRinterval = setInterval(()=>{
		currentSlide = currentSlide < slides.length - 1 ? currentSlide+=1 : 0;
		changeSlide(currentSlide);
	}, 6000);
}

function changeSlide(n){
	clearInterval(slideRinterval);
	for (let i = 0; i < slides.length; i++){
		slides[i].classList.remove('active');
		sliderDots[i].classList.remove('active');
	}
	slides[n].classList.add('active');
	sliderDots[n].classList.add('active');
	initSlider();	
}


var xDown = null;                                                        
var yDown = null;

function getTouches(evt) {
  return evt.touches ||             
         evt.originalEvent.touches;
}                                                     

function handleTouchStart(evt) {
    const firstTouch = getTouches(evt)[0];                                      
    xDown = firstTouch.clientX;                                      
    yDown = firstTouch.clientY;                                      
};                                                

function handleTouchMove(evt) {
    if ( ! xDown || ! yDown ) {
        return;
    }

    var xUp = evt.touches[0].clientX;                                    
    var yUp = evt.touches[0].clientY;

    var xDiff = xDown - xUp;
    var yDiff = yDown - yUp;

    if ( Math.abs( xDiff ) > Math.abs( yDiff ) ) {/*most significant*/
        if ( xDiff > 0 ) {
            /* left swipe */
            
			if(slides.length > 0){
				currentSlide = (currentSlide < (slides.length - 1)) ? ++currentSlide : 0;
				changeSlide(currentSlide);
			}

        } else {
            /* right swipe */
            
			if(slides.length > 0){
				currentSlide = (currentSlide >0 ) ? --currentSlide : (slides.length - 1);
				changeSlide(currentSlide);
			}
        }                       
    } 
    /* reset values */
    xDown = null;
    yDown = null;                                             
};

let book_pic_modal = document.querySelector('#show_pic .modal_content');


let picsForPreview;
let viewingNowIndex = 0;
let bigPic;

function showBigBookPicture(book){
	let bookpath = book.dataset.bigimage;
	if(bookpath.length < 2) {
		bookpath = book.getAttribute('src');
	}
	picsForPreview = book.parentNode.parentNode.querySelectorAll('.book_miniature');

	let currPic;
	for(let i = 0; i < picsForPreview.length; i++){
		if(picsForPreview[i].dataset.bigimage === bookpath){
		// if(picsForPreview[i].getAttribute('src') === bookpath){
			currPic = picsForPreview[i];
			viewingNowIndex = i;
		}
	}

	let img; 
	let imgInMd = book_pic_modal.querySelector('img');
	if(imgInMd != null){
		img = imgInMd;
	}
	else{
		img = new Image();
	}
	
	img.src = bookpath;
	book_pic_modal.append(img);
	bigPic = img;
	book_pic_modal.parentNode.style.display = 'flex';
}


function showPrevPic(){
	if(viewingNowIndex > 0){
		viewingNowIndex--;
	}
	else{
		viewingNowIndex = picsForPreview.length - 1;
	}
	bigPic.src = picsForPreview[viewingNowIndex].getAttribute('src');
}

function showNextPic(){
	if(viewingNowIndex < picsForPreview.length - 1){
		viewingNowIndex++;
	}
	else{
		viewingNowIndex = 0;
	}
	bigPic.src = picsForPreview[viewingNowIndex].getAttribute('src');
}