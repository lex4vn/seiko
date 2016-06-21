<?php if( $banners ) { ?>
<?php if( isset($widget_name)){
?>
<span class="menu-title"><?php echo $widget_name;?></span>
<?php
}?>
<div class="widget-banner container">
	<div class="widget-inner clearfix">
			
		  <?php $number = count($banners); { ?>
		  <?php if($number == 1) { $clazz = 'col-lg-12 col-md-12 col-sm-12 col-xs-12'; } ?>
		  <?php if($number == 2) { $clazz = 'col-lg-6 col-md-6 col-sm-6 col-xs-6'; } ?>
		  <?php if($number >= 3) { $clazz = 'col-lg-4 col-md-4 col-sm-4 col-xs-4'; } ?>
		  <?php foreach ($banners as $banner) { ?>
		  <?php if ($banner['link']) { ?>
		  <div class="w-banner <?php echo $clazz?>"><a href="<?php echo $banner['link']; ?>"><img class="img-responsive" src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></a></div>
		  <?php } else { ?>
		  <div class="<?php echo $clazz?>"><img class="img-responsive" src="<?php echo $banner['image']; ?>" alt="<?php echo $banner['title']; ?>" title="<?php echo $banner['title']; ?>" /></div>
		  <?php } ?>
		  <?php } ?>
	</div>
</div>
<?php } ?>
<?php } ?>