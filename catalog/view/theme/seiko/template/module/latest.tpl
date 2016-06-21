<?php
	$load = $this->registry->get("load");
	$language = $load->language("module/themecontrol");
	$text_sale = $language['text_sale'];
	$quick_view = $language['quick_view'];
  	$config = $this->registry->get('config'); 
	$theme  = $config->get('config_template');
	$cols = isset($customcols)? $customcols : 4;
	$span = 12/$cols;
					$themeConfig  	 			= (array)$config->get('themecontrol');
						$listingConfig  			= array(
				'category_pzoom' 		=> 1,
				'show_swap_image' 		=> 0,
					'quickview' 			=> 0,
				'product_layout'		=> 'default',
					'catalog_mode'			=> '',
	);
				$listingConfig  			= array_merge($listingConfig, $themeConfig );
				$categoryPzoom 	    		= $listingConfig['category_pzoom'];
						$quickview 					= $listingConfig['quickview'];
						$swapimg 					= ($listingConfig['show_swap_image'])?'swap':'';

	if( isset($_COOKIE[$theme.'_productlayout']) && $listingConfig['enable_paneltool'] && $_COOKIE[$theme.'_productlayout'] ){
		$listingConfig['product_layout'] = trim($_COOKIE[$theme.'_productlayout']);
	}
	
	$productLayout = DIR_TEMPLATE.$theme.'/template/common/product/'.$listingConfig['product_layout'].'.tpl';
	if( !is_file($productLayout) ){
		$listingConfig['product_layout'] = 'default';
	}
  	$productLayout = DIR_TEMPLATE.$config->get('config_template').'/template/common/product/'.$listingConfig['product_layout'].'.tpl'; 
	$ourl = $this->registry->get('url');
?>
<div class="panel panel-v2 latest container">
<div class="panel-heading">
	<span class="leftline"></span>
	<h3 class="panel-title"><?php echo $heading_title; ?></h3>
	<span class="rightline"></span>
</div>
<div id="tabs" class="htabs">
	<ul id="moduletabs" class="nav nav-pills">
		<li class="active"><a href="#tab-allcat" data-toggle="tab"><?php echo $allcat; ?></a></li>
		<li><a href="#tab-cat1"  data-toggle="tab"><?php echo $cat1; ?></a></li>
		<li><a href="#tab-cat2"  data-toggle="tab"><?php echo $cat2; ?></a></li>
	</ul>
</div>
<div id="tab-contents" class="tab-content">
	<div id="tab-allcat"  class="tab-pane active products-block">
		<?php foreach ($products as $i=> $product) { $i=$i+1; ?>
		<?php if( $i%$cols==1 && $cols> 1 ) { ?>
		<div class="row products-row">
			<?php } ?>
			<div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-6 col-xs-12 product-col border">
				<?php require( $productLayout ); ?>
			</div>
			<?php if( ($i%$cols==0 || $i==count($products) ) && $cols> 1 ) { ?>
		</div>
		<?php } ?>
		<?php } ?>
	</div>
	<div id="tab-cat1"  class="tab-pane products-block">
		<?php if(!is_null($products1)){ ?>
		<?php foreach ($products1 as $i=> $product) { $i=$i+1; ?>
		<?php if( $i%$cols==1 && $cols> 1 ) { ?>
		<div class="row products-row">
			<?php } ?>
			<div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-6 col-xs-12 product-col border">
				<?php require( $productLayout ); ?>
			</div>
			<?php if( ($i%$cols==0 || $i==count($products) ) && $cols> 1 ) { ?>
		</div>
		<?php } ?>
		<?php } ?>
		<?php } ?>
	</div>	
	<div id="tab-cat2"  class="tab-pane products-block">
		<?php if(!is_null($products2)){ ?>
		<?php foreach ($products2 as $i=> $product) { $i=$i+1; ?>
		<?php if( $i%$cols==1 && $cols> 1 ) { ?>
		<div class="row products-row">
			<?php } ?>
			<div class="col-lg-<?php echo $span;?> col-md-<?php echo $span;?> col-sm-6 col-xs-12 product-col border">
				<?php require( $productLayout ); ?>
			</div>
			<?php if( ($i%$cols==0 || $i==count($products) ) && $cols> 1 ) { ?>
		</div>
		<?php } ?>
		<?php } ?>
		<?php } ?>
	</div>		
</div>
<!-- End tab-contents-->
<div class="view-all"><a href="./san-pham"><span>Xem tất cả</span></a></div>
</div>