<div class="panel panel<?php echo $prefixclass;?> latest-posts-v4">
	<div class="panel-heading">
    <?php if(isset($titlenewsarticle)){ ?>
    <h3 class="panel-title-sitebar"><?php echo $titlenewsarticle; ?></h3>
    <?php }else {?>
    <span class="leftline"></span>
	<h3 class="panel-title">Bản tin</h3>
	<span class="rightline"></span>
    <?php } ?>

	</div>
	<div id="tabs-news" class="htabs <?php echo isset($titlenewsarticle)?'hidden':'' ?>">
		<ul id="moduletabs" class="nav nav-pills">
            <?php if(isset($titlenewsarticle)){ ?>
            <li class="active"><a href="#tabnews" data-toggle="tab"><?php echo $titlenewsarticle; ?></a></li>
            <?php }else {?>
			<li class="active"><a href="#tabnews" data-toggle="tab"><?php echo $newstitle; ?></a></li>
			<li><a href="#tabcomment"  data-toggle="tab"><?php echo $commenttitle; ?></a></li>
            <?php } ?>
		</ul>
	</div>
	<div id="tab-contents-news" class="tab-content">
	<div id="tabnews"  class="tab-pane active products-block">
		<div class="blogs-block">
			<?php if( !empty($blogs) ) { ?>
			<div class="row">
				<?php foreach( $blogs as $key => $blog ) { $key = $key + 1;?>
				<?php $style = ( $key > $cols )?"left":"right";  ?>
				<div class="col-lg-<?php echo floor(12/$cols);?> col-md-<?php echo floor(12/$cols);?> col-sm-6 col-xs-12 <?php echo $style; ?>">	
					<div class="latest-posts-body">
						  	<a class="" href="#">
							    <?php if( $blog['thumb']  )  { ?>
									<img class="img-responsive" src="<?php echo $blog['thumb'];?>" title="<?php echo $blog['title'];?>" alt="<?php echo $blog['title'];?>"/>
								<?php } ?>
						  	</a>
	
					  	<div class="latest-posts-meta media-body">
					  		<h6 class="latest-posts-title"><a href="<?php echo $blog['link'];?>" title="<?php echo $blog['title'];?>"><?php echo $blog['title'];?></a></h6>
	
							<div class="posts-meta">												
						    <div class="description space-10">
								<?php $blog['description'] = strip_tags($blog['description']); ?>
								<?php echo utf8_substr( $blog['description'],0, 100 );?>...
							</div>
							<div class="btn-more-link hidden">
								<a href="<?php echo $blog['link'];?>" class="readmore btn-link"><?php echo $objlang->get('text_readmore');?><i class="space-padding-l5 fa fa-angle-right"></i></a>
							</div>
					  	</div>
					</div>
					</div> <!-- end latest-posts-body -->
				</div>
				<?php } ?>
			</div>
			<?php } ?>
		</div>
	</div>
    <?php if(!isset($titlenewsarticle)){ ?>
	<div id="tabcomment"  class="tab-pane products-block">
		<?php if( !empty($comments) ) { ?>
		<div class="pavblog-comments clearfix">
			 <?php $default=''; foreach( $comments as $comment ) { ?>
				<div class="pav-comment media col-lg-6 col-md-6 col-sm-6 col-xs-12 right">
					<a class="media-left" href="<?php echo $comment['link'];?>" title="<?php echo $comment['user'];?>">
						<img src="<?php echo "http://www.gravatar.com/avatar/" . md5( strtolower( trim( $comment['email'] ) ) ) . "?d=" . urlencode( $default ) . "&s=60" ?>"/>
					</a>
					<div class="content media-right">
						<div class="comment"><?php echo utf8_substr( $comment['comment'],0, 50 ); ?>...</div>
						<div class="comment-author text-primary"><?php echo $objlang->get('text_postedby');?> <?php echo $comment['user'];?>...</div>
					</div>
				</div>
			 <?php } ?>
		</div>
		<?php } ?>
	</div>	
    <?php } ?>
</div>
<!-- End tab-contents-->
<div class="view-all"><a href="./tin-tuc"><span>Xem tất cả</span></a></div>


	
	
	
</div>
