<?php if($status){ ?>
	<?php if($config_company){ ?>
	  <?php if($config_company_syntax == "ld" or $config_company_syntax == "all"){ ?>
		<script type="application/ld+json">
			{
			  "@context": "https://schema.org",
			  "@type": "Organization",
			  "url": "<?php echo $microdata_base_url; ?>",
			  "name": "<?php echo $microdata_name; ?>",
			  "email": "<?php echo $microdata_email; ?>",
			  "logo": "<?php echo $microdata_logo; ?>",
			  <?php if ($microdata_address_1 && $microdata_address_2 && $microdata_address_3){ ?>
			  "address": {
				"@type": "PostalAddress",
				"addressLocality": "<?php echo $microdata_address_1; ?>",
				"postalCode": "<?php echo $microdata_address_2; ?>",
				"streetAddress": "<?php echo $microdata_address_3; ?>"
			  },
			  <?php } ?>	  
			  "potentialAction": {
				"@type": "SearchAction",
				"target": "<?php echo $microdata_base_url; ?>index.php?route=product/search&search={search_term_string}",
				"query-input": "required name=search_term_string"
			  }<?php if ($microdata_phones){ ?>,	  
			  "contactPoint" : [
			  <?php $pi = 1; foreach($microdata_phones as $phone){ ?>{
				"@type" : "ContactPoint",
				"telephone" : "<?php echo $phone; ?>",
				"contactType" : "customer service"
			  }<?php if($pi != count($microdata_phones)){ ?>,<?php } ?><?php $pi++; } ?>]<?php } ?><?php if ($microdata_groups){ ?>,
			  "sameAs" : [
				<?php $gi = 1; foreach($microdata_groups as $group){ ?>
				 "<?php echo $group; ?>"<?php if($gi != count($microdata_groups)){ ?>,<?php } ?>
				<?php $gi++; } ?>
			  ]<?php } ?>	  
			}	  
		</script>
	  <?php } ?>
	  <?php if($config_company_syntax == "md" or $config_company_syntax == "all"){ ?>
		<div itemscope itemtype="https://schema.org/Organization" style="display:none;">
		  <meta itemprop="name" content="<?php echo $microdata_name; ?>" />
		  <link itemprop="url" href="<?php echo $microdata_base_url; ?>" />
		  <link itemprop="logo" href="<?php echo $microdata_logo; ?>" />
		  <meta itemprop="email" content="<?php echo $microdata_email; ?>" />
		  <?php if ($microdata_address_1 && $microdata_address_2 && $microdata_address_3){ ?>
			  <div itemprop="address" itemscope itemtype="https://schema.org/PostalAddress">
				<meta itemprop="addressLocality" content="<?php echo $microdata_address_1; ?>" />			  
				<meta itemprop="postalCode" content="<?php echo $microdata_address_2; ?>" />
				<meta itemprop="streetAddress" content="<?php echo $microdata_address_3; ?>" />
			  </div>
		  <?php } ?>
		  <?php if ($microdata_phones){ ?>
		   <?php foreach($microdata_phones as $phone){ ?>
			<meta itemprop="telephone" content="<?php echo $phone; ?>" />
		   <?php } ?>
		  <?php } ?>
		  <?php if ($microdata_groups){ ?>
		   <?php foreach($microdata_groups as $group){ ?>
			<link itemprop="sameAs" href="<?php echo $group; ?>" />
		   <?php } ?>
		  <?php } ?>
		  <form itemprop="potentialAction" itemscope itemtype="https://schema.org/SearchAction">
			  <meta itemprop="target" content="<?php echo $microdata_base_url; ?>index.php?route=product/search&search={search_term_string}"/>
			  <input itemprop="query-input" type="text" required name="search_term_string"/>
		  </form>		  
		</div>
	  <?php } ?>
	<?php } ?>
	<?php if($microdata_route_product && $config_product_page){ ?>
		<?php if($config_product_breadcrumb){ ?>
		  <?php if($config_product_syntax == "ld" or $config_product_syntax == "all"){ ?>
			<script type="application/ld+json">
				{
				  "@context": "https://schema.org",
				  "@type": "BreadcrumbList",
				  "itemListElement": [<?php $bi = 1; foreach ($microdata_breadcrumbs as $breadcrumb) { ?>{
					"@type": "ListItem",
					"position": <?php echo $bi; ?>,
					"item": {
					  "@id": "<?php echo $breadcrumb['href']; ?>",
					  "name": "<?php echo $breadcrumb['text']; ?>"
					}
				  }<?php if($bi != count($microdata_breadcrumbs)){ ?>,<?php } ?><?php $bi++; } ?>]
				}	  
			</script>
		  <?php } ?>
		  <?php if($config_product_syntax == "md" or $config_product_syntax == "all"){ ?>
			<div itemscope itemtype="https://schema.org/BreadcrumbList" style="display:none;">
			 <?php $bi = 1; foreach ($microdata_breadcrumbs as $breadcrumb) { ?>
			  <div itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
				<link itemprop="item" href="<?php echo $breadcrumb['href']; ?>">
				<meta itemprop="name" content="<?php echo $breadcrumb['text']; ?>" />
				<meta itemprop="position" content="<?php echo $bi; ?>" />
			  </div>
			 <?php $bi++; } ?>
			</div>			
		  <?php } ?>
		<?php } ?>
		<?php if($config_product_syntax == "ld" or $config_product_syntax == "all"){ ?>
			<script type="application/ld+json">
				{
				  "@context": "https://schema.org",
				  "@type": "Product",
				  "url": "<?php echo $microdata_product_url; ?>",
				  <?php if(isset($microdata_breadcrumbs[count($microdata_breadcrumbs)-2]['text']) && (count($microdata_breadcrumbs)-2) != 0){ ?>
				  "category": "<?php echo $microdata_breadcrumbs[count($microdata_breadcrumbs)-2]['text']; ?>",
				  <?php } ?>
				  <?php if($microdata_popup){ ?>
				  "image": "<?php echo $microdata_popup; ?>",
				  <?php }?>
				  <?php if ($microdata_manufacturer) { ?>
				  "brand": "<?php echo $microdata_manufacturer; ?>",
				  "manufacturer": "<?php echo $microdata_manufacturer; ?>",
				  <?php } ?>
				  <?php if ($microdata_model) { ?>
				  "model": "<?php echo $microdata_model; ?>",
				  <?php } ?>	  
				  <?php if($microdata_review_total){ ?>
				  "aggregateRating": {
					"@type": "AggregateRating",
					"ratingValue": "<?php echo $microdata_total_rating_value; ?>",
					"reviewCount": "<?php echo $microdata_review_total; ?>"
				  },<?php } ?>
				  "description": "<?php echo $microdata_description; ?>",
				  "name": "<?php echo $microdata_heading_title; ?>",
				  "offers": {
					"@type": "Offer",
					"availability": "https://schema.org/<?php echo ($microdata_stock > 0)?"InStock":"OutOfStock"; ?>",
					"price": "<?php echo $microdata_price; ?>",
					"priceCurrency": "<?php echo $microdata_code; ?>"
				  }<?php if ($microdata_reviews && $config_product_reviews){ ?>,
				  "review": [
					<?php $ri = 1; foreach ($microdata_reviews as $review_item){ ?>
					{
					  "@type": "Review",
					  "author": "<?php echo $review_item['author']; ?>",
					  "datePublished": "<?php echo $review_item['date_added']; ?>",
					  "description": "<?php echo $review_item['text']; ?>",
					  "reviewRating": {
						"@type": "Rating",
						"bestRating": "5",
						"ratingValue": "<?php echo $review_item['rating']; ?>",
						"worstRating": "1"
					  }
					}<?php if($ri != count($microdata_reviews)){ ?>,<?php } ?><?php $ri++; } ?>
				  ]<?php } ?>
				  <?php if($microdata_products && $config_product_related){ ?>
					,"isRelatedTo": [
					  <?php $pri = 1; foreach($microdata_products as $product){ ?>
						{
						  "@type": "Product",
						  "image": "<?php echo $product['thumb']; ?>",
						  "url": "<?php echo $product['href']; ?>",
						  "name": "<?php echo $product['name']; ?>",
						  "description": "<?php echo $product['microdata_description']; ?>",
						  "offers": {
							"@type": "Offer",
							"price": "<?php echo $product['microdata_price']; ?>",
							"priceCurrency": "<?php echo $microdata_code; ?>"
						  }
						}<?php if($pri != count($microdata_products)){ ?>,<?php } ?><?php $pri++; } ?>	
					]
				  <?php } ?>
				  <?php if ($microdata_attribute_groups && $config_product_attribute) { ?>
				  ,"additionalProperty":[
					<?php $ag = 1; foreach ($microdata_attribute_groups as $attribute_group) { ?>
					 <?php $ai = 1; foreach ($attribute_group['attribute'] as $attribute) { ?>
						{
						  "@type": "PropertyValue",
						  "name": "<?php echo $attribute['name']; ?>",
						  "value": "<?php echo $attribute['text']; ?>"
						}<?php if($ai != count($attribute_group['attribute']) or $ag != count($microdata_attribute_groups)){ ?>,<?php } ?>
					 <?php $ai++; } ?>	
					<?php $ag++; } ?>	
				  ]
				  <?php } ?>
				}
			</script>
		<?php } ?>	
		<?php if($config_product_syntax == "md" or $config_product_syntax == "all"){ ?>
		 <div <?php if($microdata_products && $config_product_related){ ?><?php $pri = 1; foreach($microdata_products as $product){ ?>itemref="related-product-<?php echo $pri; ?>"<?php $pri++; } ?><?php } ?> itemscope itemtype="https://schema.org/Product" style="display:none;">
		  <meta itemprop="name" content="<?php echo $microdata_heading_title; ?>" />
		  <link itemprop="url" href="<?php echo $microdata_product_url; ?>" />
		  <?php if($microdata_popup){ ?>
			<link itemprop="image" href="<?php echo $microdata_popup; ?>" />
		  <?php } ?>
		  <?php if ($microdata_manufacturer) { ?>
			<meta itemprop="brand" content="<?php echo $microdata_manufacturer; ?>" />
			<meta itemprop="manufacturer" content="<?php echo $microdata_manufacturer; ?>" />
		  <?php } ?>
		  <?php if ($microdata_model) { ?>
			<meta itemprop="model" content="<?php echo $microdata_model; ?>" />
		  <?php } ?>
		  <?php if(isset($microdata_breadcrumbs[count($microdata_breadcrumbs)-2]['text']) && (count($microdata_breadcrumbs)-2) != 0){ ?>
			<meta itemprop="category" content="<?php echo $microdata_breadcrumbs[count($microdata_breadcrumbs)-2]['text']; ?>" />
		  <?php } ?>
		  <?php if($microdata_review_total){ ?>
			<div itemprop="aggregateRating" itemscope itemtype="https://schema.org/AggregateRating">
			 <meta itemprop="ratingValue" content="<?php echo $microdata_total_rating_value; ?>">
			 <meta itemprop="reviewCount" content="<?php echo $microdata_review_total; ?>">
		   </div>
		  <?php } ?>
		  <div itemprop="offers" itemscope itemtype="https://schema.org/Offer">
			<meta itemprop="priceCurrency" content="<?php echo $microdata_code; ?>" />
			<meta itemprop="price" content="<?php echo $microdata_price; ?>" />
			<link itemprop="availability" href="https://schema.org/<?php echo ($microdata_stock > 0)?"InStock":"OutOfStock"; ?>" />
		  </div>
		  <meta itemprop="description" content="<?php echo $microdata_description; ?>" />
		  <?php if ($microdata_reviews && $config_product_reviews){ ?>
			<?php foreach($microdata_reviews as $review_item){ ?>
			  <div itemprop="review" itemscope itemtype="https://schema.org/Review">
				<meta itemprop="author" content="<?php echo $review_item['author']; ?>" />
				<meta itemprop="datePublished" content="<?php echo $review_item['date_added']; ?>" />
				<div itemprop="reviewRating" itemscope itemtype="https://schema.org/Rating">
				  <meta itemprop="worstRating" content = "1" />
				  <meta itemprop="ratingValue" content="<?php echo $review_item['rating']; ?>" />
				  <meta itemprop="bestRating" content="5" />
				</div>
				<meta itemprop="description" content="<?php echo $review_item['text']; ?>" />
			  </div>
			<?php }?>
		  <?php } ?>
		  <?php if($microdata_products && $config_product_related){ ?>
			<?php $pri = 1; foreach($microdata_products as $product){ ?>
			 <div id="related-product-<?php echo $pri; ?>" itemprop="isRelatedTo" itemscope itemtype="https://schema.org/Product">
			   <meta itemprop="name" content="<?php echo $product['name']; ?>" />
			   <meta itemprop="description" content="<?php echo $product['microdata_description']; ?>" />
			   <link itemprop="url" href="<?php echo $product['href']; ?>" />
			   <link itemprop="image" href="<?php echo $product['thumb']; ?>" />
			   <div itemprop="offers" itemscope itemtype="https://schema.org/Offer">
				<meta itemprop="priceCurrency" content="<?php echo $microdata_code; ?>" />
				<meta itemprop="price" content="<?php echo $product['microdata_price']; ?>" />
			   </div>	   
			 </div>	
			<?php $pri++; } ?>
		  <?php } ?>
		  <?php if ($microdata_attribute_groups && $config_product_attribute) { ?>
			<?php foreach ($microdata_attribute_groups as $attribute_group) { ?>
			 <?php foreach ($attribute_group['attribute'] as $attribute) { ?>
			   <div itemprop="additionalProperty" itemscope itemtype="https://schema.org/PropertyValue">
				 <meta itemprop="value" content="<?php echo $attribute['text']; ?>" />
				 <meta itemprop="name" content="<?php echo $attribute['name']; ?>" />
			   </div>
			 <?php } ?>
			<?php } ?>
		  <?php } ?>
		 </div>
		<?php } ?>	
	<?php } ?>
	<?php if($microdata_route_category && $config_category_page){ ?>
		<?php if($config_category_breadcrumb){ ?>
		 <?php if($config_category_syntax == "ld" or $config_category_syntax == "all"){ ?>
		  <script type="application/ld+json">
			{
			  "@context": "https://schema.org",
			  "@type": "BreadcrumbList",
			  "itemListElement": [<?php $bi = 1; foreach ($microdata_breadcrumbs as $breadcrumb) { ?>{
				"@type": "ListItem",
				"position": <?php echo $bi; ?>,
				"item": {
				  "@id": "<?php echo $breadcrumb['href']; ?>",
				  "name": "<?php echo $breadcrumb['text']; ?>"
				}
			  }<?php if($bi != count($microdata_breadcrumbs)){ ?>,<?php } ?><?php $bi++; } ?>]
			}
		  </script>
		 <?php } ?>
		 <?php if($config_category_syntax == "md" or $config_category_syntax == "all"){ ?>
			<div itemscope itemtype="https://schema.org/BreadcrumbList" style="display:none;">
			 <?php $bi = 1; foreach ($microdata_breadcrumbs as $breadcrumb) { ?>
			  <div itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
				<link itemprop="item" href="<?php echo $breadcrumb['href']; ?>">
				<meta itemprop="name" content="<?php echo $breadcrumb['text']; ?>" />
				<meta itemprop="position" content="<?php echo $bi; ?>" />
			  </div>
			 <?php $bi++; } ?>
			</div>		 
		 <?php } ?>
		<?php } ?>
		<?php if($microdata_category_products){ ?>
		<?php if($config_category_syntax == "ld" or $config_category_syntax == "all"){ ?>
		  <script type="application/ld+json">
			{
			  "@context": "https://schema.org",
			  "@type": "ItemList",
			  "url": "<?php echo $microdata_category_url; ?>",
			  <?php if($microdata_description){ ?>"description": "<?php echo $microdata_description; ?>",<?php } ?>
			  "numberOfItems": "<?php echo count($microdata_category_products); ?>",
			  "itemListElement": [
				<?php $pi = 1; foreach($microdata_category_products as $product){ ?>{
				  "@type": "Product",
				  "image": "<?php echo $product['thumb']; ?>",
				  "url": "<?php echo $product['href']; ?>",
				  "name": "<?php echo $product['name']; ?>",
				  "description": "<?php echo $product['microdata_description']; ?>",
				  "offers": {
					"@type": "Offer",
					"price": "<?php echo $product['microdata_price']; ?>",
					"priceCurrency": "<?php echo $microdata_code; ?>"
				  }
				}<?php if($pi != count($microdata_category_products)){ ?>,<?php } ?><?php $pi++; } ?>
			  ]
			}
		  </script>
		 <?php } ?>
		 <?php if($config_category_syntax == "md" or $config_category_syntax == "all"){ ?>
		  <div itemtype="https://schema.org/ItemList" itemscope style="display:none;">
		   <?php if($microdata_description){ ?><meta itemprop="description" content="<?php echo $microdata_description; ?>" /><?php } ?>
		   <link itemprop="url" href="<?php echo $microdata_category_url; ?>" />
		   <meta itemprop="numberOfItems" content="<?php echo count($microdata_category_products); ?>" />
		   <?php foreach($microdata_category_products as $product){ ?>
		    <div itemprop="itemListElement" itemscope itemtype="https://schema.org/Product">
		       <meta itemprop="name" content="<?php echo $product['name']; ?>" />
		       <meta itemprop="description" content="<?php echo $product['microdata_description']; ?>" />
			   <link itemprop="url" href="<?php echo $product['href']; ?>" />
			   <link itemprop="image" href="<?php echo $product['thumb']; ?>" />
			   <div itemprop="offers" itemscope itemtype="https://schema.org/Offer">
				<meta itemprop="priceCurrency" content="<?php echo $microdata_code; ?>" />
				<meta itemprop="price" content="<?php echo $product['microdata_price']; ?>" />
			   </div>				
			</div>
		   <?php } ?>	
		  </div>
		 <?php } ?>
		<?php } ?>
	<?php } ?>
	<?php if($microdata_route_manufacturer && $config_manufacturer_page){ ?>
		<?php if($config_manufacturer_breadcrumb){ ?>
		 <?php if($config_manufacturer_syntax == "ld" or $config_manufacturer_syntax == "all"){ ?>
		  <script type="application/ld+json">
			{
			  "@context": "https://schema.org",
			  "@type": "BreadcrumbList",
			  "itemListElement": [<?php $bi = 1; foreach ($microdata_breadcrumbs as $breadcrumb) { ?>{
				"@type": "ListItem",
				"position": <?php echo $bi; ?>,
				"item": {
				  "@id": "<?php echo $breadcrumb['href']; ?>",
				  "name": "<?php echo $breadcrumb['text']; ?>"
				}
			  }<?php if($bi != count($microdata_breadcrumbs)){ ?>,<?php } ?><?php $bi++; } ?>]
			}	  
		  </script>
		 <?php } ?>
		 <?php if($config_manufacturer_syntax == "md" or $config_manufacturer_syntax == "all"){ ?>
			<div itemscope itemtype="https://schema.org/BreadcrumbList" style="display:none;">
			 <?php $bi = 1; foreach ($microdata_breadcrumbs as $breadcrumb) { ?>
			  <div itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
				<link itemprop="item" href="<?php echo $breadcrumb['href']; ?>">
				<meta itemprop="name" content="<?php echo $breadcrumb['text']; ?>" />
				<meta itemprop="position" content="<?php echo $bi; ?>" />
			  </div>
			 <?php $bi++; } ?>
			</div>		 
		 <?php } ?>		
		<?php } ?>
		<?php if($microdata_manufacturer_products){ ?>
		 <?php if($config_manufacturer_syntax == "ld" or $config_manufacturer_syntax == "all"){ ?>
		  <script type="application/ld+json">
			{
			  "@context": "https://schema.org",
			  "@type": "ItemList",
			  "url": "<?php echo $microdata_manufacturer_url; ?>",
			  <?php if($microdata_description){ ?>"description": "<?php echo $microdata_description; ?>",<?php } ?>
			  "numberOfItems": "<?php echo count($microdata_manufacturer_products); ?>",
			  "itemListElement": [
				<?php $pi = 1; foreach($microdata_manufacturer_products as $product){ ?>{
				  "@type": "Product",
				  "image": "<?php echo $product['thumb']; ?>",
				  "url": "<?php echo $product['href']; ?>",
				  "name": "<?php echo $product['name']; ?>",
				  "description": "<?php echo $product['microdata_description']; ?>",
				  "offers": {
					"@type": "Offer",
					"price": "<?php echo $product['microdata_price']; ?>",
					"priceCurrency": "<?php echo $microdata_code; ?>"
				  }
				}<?php if($pi != count($microdata_manufacturer_products)){ ?>,<?php } ?><?php $pi++; } ?>
			  ]
			}
		  </script>
		 <?php } ?>
		 <?php if($config_manufacturer_syntax == "md" or $config_manufacturer_syntax == "all"){ ?>
		  <div itemtype="https://schema.org/ItemList" itemscope style="display:none;">
		   <?php if($microdata_description){ ?><meta itemprop="description" content="<?php echo $microdata_description; ?>" /><?php } ?>
		   <link itemprop="url" href="<?php echo $microdata_manufacturer_url; ?>" />
		   <meta itemprop="numberOfItems" content="<?php echo count($microdata_manufacturer_products); ?>" />
		   <?php foreach($microdata_manufacturer_products as $product){ ?>
		    <div itemprop="itemListElement" itemscope itemtype="https://schema.org/Product">
		       <meta itemprop="name" content="<?php echo $product['name']; ?>" />
		       <meta itemprop="description" content="<?php echo $product['microdata_description']; ?>" />
			   <link itemprop="url" href="<?php echo $product['href']; ?>" />
			   <link itemprop="image" href="<?php echo $product['thumb']; ?>" />
			   <div itemprop="offers" itemscope itemtype="https://schema.org/Offer">
				<meta itemprop="priceCurrency" content="<?php echo $microdata_code; ?>" />
				<meta itemprop="price" content="<?php echo $product['microdata_price']; ?>" />
			   </div>				
			</div>
		   <?php } ?>	
		  </div>			
		 <?php } ?>
		<?php } ?>
	<?php } ?>
	<?php if($microdata_route_special && $config_special_page){ ?>
		<?php if($config_special_breadcrumb){ ?>
		 <?php if($config_special_syntax == "ld" or $config_special_syntax == "all"){ ?>
		  <script type="application/ld+json">
			{
			  "@context": "https://schema.org",
			  "@type": "BreadcrumbList",
			  "itemListElement": [<?php $bi = 1; foreach ($microdata_breadcrumbs as $breadcrumb) { ?>{
				"@type": "ListItem",
				"position": <?php echo $bi; ?>,
				"item": {
				  "@id": "<?php echo $breadcrumb['href']; ?>",
				  "name": "<?php echo $breadcrumb['text']; ?>"
				}
			  }<?php if($bi != count($microdata_breadcrumbs)){ ?>,<?php } ?><?php $bi++; } ?>]
			}	  
		  </script>
		 <?php } ?>
		 <?php if($config_special_syntax == "md" or $config_special_syntax == "all"){ ?>
			<div itemscope itemtype="https://schema.org/BreadcrumbList" style="display:none;">
			 <?php $bi = 1; foreach ($microdata_breadcrumbs as $breadcrumb) { ?>
			  <div itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
				<link itemprop="item" href="<?php echo $breadcrumb['href']; ?>">
				<meta itemprop="name" content="<?php echo $breadcrumb['text']; ?>" />
				<meta itemprop="position" content="<?php echo $bi; ?>" />
			  </div>
			 <?php $bi++; } ?>
			</div>		 
		 <?php } ?>			  
		<?php } ?>
		<?php if($microdata_special_products){ ?>
		 <?php if($config_special_syntax == "ld" or $config_special_syntax == "all"){ ?>
		  <script type="application/ld+json">
			{
			  "@context": "https://schema.org",
			  "@type": "ItemList",
			  "url": "<?php echo $microdata_special_url; ?>",
			  <?php if($microdata_description){ ?>"description": "<?php echo $microdata_description; ?>",<?php } ?>
			  "numberOfItems": "<?php echo count($microdata_special_products); ?>",
			  "itemListElement": [
				<?php $pi = 1; foreach($microdata_special_products as $product){ ?>{
				  "@type": "Product",
				  "image": "<?php echo $product['thumb']; ?>",
				  "url": "<?php echo $product['href']; ?>",
				  "name": "<?php echo $product['name']; ?>",
				  "description": "<?php echo $product['microdata_description']; ?>",
				  "offers": {
					"@type": "Offer",
					"price": "<?php echo $product['microdata_price']; ?>",
					"priceCurrency": "<?php echo $microdata_code; ?>"
				  }
				}<?php if($pi != count($microdata_special_products)){ ?>,<?php } ?><?php $pi++; } ?>
			  ]
			}
		  </script>
		 <?php } ?>
		 <?php if($config_special_syntax == "md" or $config_special_syntax == "all"){ ?>
		  <div itemscope itemtype="https://schema.org/ItemList" style="display:none;">
		   <?php if($microdata_description){ ?><meta itemprop="description" content="<?php echo $microdata_description; ?>" /><?php } ?>
		   <link itemprop="url" href="<?php echo $microdata_special_url; ?>" />
		   <meta itemprop="numberOfItems" content="<?php echo count($microdata_special_products); ?>" />
		   <?php foreach($microdata_special_products as $product){ ?>
		    <div itemprop="itemListElement" itemscope itemtype="https://schema.org/Product">
		       <meta itemprop="name" content="<?php echo $product['name']; ?>" />
		       <meta itemprop="description" content="<?php echo $product['microdata_description']; ?>" />
			   <link itemprop="url" href="<?php echo $product['href']; ?>" />
			   <link itemprop="image" href="<?php echo $product['thumb']; ?>" />
			   <div itemprop="offers" itemscope itemtype="https://schema.org/Offer">
				<meta itemprop="priceCurrency" content="<?php echo $microdata_code; ?>" />
				<meta itemprop="price" content="<?php echo $product['microdata_price']; ?>" />
			   </div>				
			</div>
		   <?php } ?>	
		  </div>			
		 <?php } ?>		  
		<?php } ?>
	<?php } ?>
	<?php if($microdata_route_information && $config_information_page){ ?>
		<?php if($config_information_breadcrumb){ ?>
		 <?php if($config_information_syntax == "ld" or $config_information_syntax == "all"){ ?>		
		  <script type="application/ld+json">
			{
			  "@context": "https://schema.org",
			  "@type": "BreadcrumbList",
			  "itemListElement": [<?php $bi = 1; foreach ($microdata_breadcrumbs as $breadcrumb) { ?>{
				"@type": "ListItem",
				"position": <?php echo $bi; ?>,
				"item": {
				  "@id": "<?php echo $breadcrumb['href']; ?>",
				  "name": "<?php echo $breadcrumb['text']; ?>"
				}
			  }<?php if($bi != count($microdata_breadcrumbs)){ ?>,<?php } ?><?php $bi++; } ?>]
			}	  
		  </script>
		 <?php } ?>
		 <?php if($config_information_syntax == "md" or $config_information_syntax == "all"){ ?>
			<div itemscope itemtype="https://schema.org/BreadcrumbList" style="display:none;">
			 <?php $bi = 1; foreach ($microdata_breadcrumbs as $breadcrumb) { ?>
			  <div itemprop="itemListElement" itemscope itemtype="https://schema.org/ListItem">
				<link itemprop="item" href="<?php echo $breadcrumb['href']; ?>">
				<meta itemprop="name" content="<?php echo $breadcrumb['text']; ?>" />
				<meta itemprop="position" content="<?php echo $bi; ?>" />
			  </div>
			 <?php $bi++; } ?>
			</div>		 
		 <?php } ?>			  
		<?php } ?>
		 <?php if($config_information_syntax == "ld" or $config_information_syntax == "all"){ ?> 
		  <script type="application/ld+json">
			{
			  "@context": "https://schema.org",
			  "@type": "NewsArticle",
			  "mainEntityOfPage":{
				"@type":"WebPage",
				"@id": "<?php echo $microdata_information_url; ?>"
			  },
			  "headline": "<?php echo $microdata_heading_title; ?>",
			  "image": {
				"@type": "ImageObject",
				"url": "<?php echo $microdata_image; ?>",
				"width": "<?php echo $image_width; ?>",
				"height": "<?php echo $image_height; ?>"
			  },
			  "datePublished": "<?php echo $date_published; ?>",
			  "dateModified": "<?php echo $date_published; ?>",
			  "author": "<?php echo $author; ?>",					  
			  "publisher": {
				"@type": "Organization",
				"name": "<?php echo $microdata_name; ?>",
				"logo": {
				  "@type": "ImageObject",
				  "url": "<?php echo $microdata_logo; ?>"
				}
			  },
			  "description":"<?php echo $microdata_description; ?>"
			}
		  </script>
		 <?php } ?>
		 <?php if($config_information_syntax == "md" or $config_information_syntax == "all"){ ?>
			<div itemscope itemtype="https://schema.org/NewsArticle" style="display:none;">
			  <meta itemscope itemprop="mainEntityOfPage"  itemType="https://schema.org/WebPage" itemid="<?php echo $microdata_information_url; ?>"/>
			  <meta itemprop="headline" content="<?php echo $microdata_heading_title; ?>" />
			  <div itemprop="author" itemscope itemtype="https://schema.org/Person"><meta itemprop="name" content="<?php echo $author; ?>" /></div>
			  <meta itemprop="description" content="<?php echo $microdata_description; ?>">
			  <div itemprop="image" itemscope itemtype="https://schema.org/ImageObject">
				<link itemprop="contentUrl" href="<?php echo $microdata_image; ?>" />
				<link itemprop="url" href="<?php echo $microdata_image; ?>">
				<meta itemprop="width" content="<?php echo $image_width; ?>">
				<meta itemprop="height" content="<?php echo $image_height; ?>">
			  </div>
			  <div itemprop="publisher" itemscope itemtype="https://schema.org/Organization">
			  <?php if ($microdata_address_1 && $microdata_address_2 && $microdata_address_3){ ?>
				  <div itemprop="address" itemscope itemtype="https://schema.org/PostalAddress">
					<meta itemprop="addressLocality" content="<?php echo $microdata_address_1; ?>" />			  
					<meta itemprop="postalCode" content="<?php echo $microdata_address_2; ?>" />
					<meta itemprop="streetAddress" content="<?php echo $microdata_address_3; ?>" />
				  </div>
			  <?php } ?>			  
			  <?php if ($microdata_phones){ ?>
			   <?php foreach($microdata_phones as $phone){ ?>
				<meta itemprop="telephone" content="<?php echo $phone; ?>" />
			   <?php } ?>
			  <?php } ?>			  
				<div itemprop="logo" itemscope itemtype="https://schema.org/ImageObject">
				  <link itemprop="url" href="<?php echo $microdata_logo; ?>">
				  <link itemprop="contentUrl" href="<?php echo $microdata_logo; ?>" />
				</div>
				<meta itemprop="name" content="<?php echo $microdata_name; ?>" />
			  </div>
			  <meta itemprop="datePublished" content="<?php echo $date_published; ?>" />
			  <meta itemprop="dateModified" content="<?php echo $date_published; ?>" />
			</div>		 
		 <?php } ?> 
	<?php } ?>
<?php } ?>