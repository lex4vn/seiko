<?php
if (!empty($pavreassurances)) { ?>
		<div class="box-module-pavreassurances box <?php echo $prefix_class ?>">
				<div class="row">
						<?php foreach ($pavreassurances as $reassurance) { ?>
							<div class="col-lg-4 col-md-4 col-sm-4 col-xs-12 column">
								<div class="reassurances-center">
									<em class="fa <?php echo $reassurance['select_icon'] ?>"></em>
									<h2 class="ca-main"><?php echo $reassurance['title']; ?></h2>
										<?php echo htmlspecialchars_decode($reassurance['caption']); ?>
								</div>
							</div>
						<?php } ?>
				</div>
		</div>
	<?php } ?>
