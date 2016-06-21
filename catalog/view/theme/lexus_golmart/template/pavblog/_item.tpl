<div class="blog-item  space-top-20 row">
	<div class="image space-padding-tb-20 col-lg-6 col-md-6 col-sm-12 col-xs-12">
		<?php if( $blog['thumb'] && $config->get('cat_show_image') )  { ?>
		<img src="<?php echo $blog['thumb'];?>" title="<?php echo $blog['title'];?>" class="img-responsive"/>
		<?php } ?>
	</div>
	<div class="clearfix col-lg-6 col-md-6 col-sm-12 col-xs-12 blog-item-show">		
		<div class="blog-body">
			<div class="blog-header">
				<h2 class="blog-title h3">	<a href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><?php echo $blog['title'];?></a></h2>
			</div>
			<?php if( $config->get('cat_show_created') ) { ?>
			<p><span class="fa fa-clock-o">&nbsp;</span><?php echo date("d",strtotime($blog['created']));?>/<?php echo date("m",strtotime($blog['created']));?>/<?php echo date("y",strtotime($blog['created']));?></p>
			<?php } ?>
            
			<?php if( !empty($blog['description'])) { ?>
            <p>
				<?php echo utf8_substr( strip_tags($blog['description']),0, 180 );?>...
			<p>
            <?php } ?>
			<?php if( $config->get('cat_show_readmore') ) { ?>
				<a href="<?php echo $blog['link'];?>" class="text-link text-uppercase font-size-12"><?php echo $objlang->get('text_readmore');?><i class="fa fa-angle-right"></i></a>
			<?php } ?>
		</div>	

	<div class="blog-meta hidden">
		<ul class="list-inline">
		  	<li><?php if( $config->get('blog_show_author') ) { ?>
			<span class="author"><b><?php echo $objlang->get("text_write_by");?></b> <?php echo $blog['author'];?></span>
			<?php } ?>
			</li>

			<li>
			<?php if( $config->get('blog_show_category') ) { ?>
			<span class="publishin">
				<b><?php echo $objlang->get("text_published_in");?></b>
				<a class="color" href="<?php echo $blog['category_link'];?>" title="<?php echo $blog['category_title'];?>"><?php echo $blog['category_title'];?></a>
			</span>
			<?php } ?>	
			</li>

			<li>
			<?php if( $config->get('blog_show_created') ) { ?>
			<span class="created"><b><?php echo $objlang->get("text_created_date");?></b> <?php echo $blog['created'];?></span>
			<?php } ?>
			</li>

			<li>
			<?php if( $config->get('blog_show_hits') ) { ?>
			<span class="hits"><b><?php echo $objlang->get("text_hits");?></b> <?php echo $blog['hits'];?></span>
			<?php } ?>		
			</li>

			<li>
			<?php if( $config->get('blog_show_comment_counter') ) { ?>
			<span class="comment_count"><b><?php echo $objlang->get("text_comment_count");?></b> <?php echo $blog['comment_count'];?></span>
			<?php } ?>	
			</li>
		</ul>
	</div>		
	</div>		
	
</div>
