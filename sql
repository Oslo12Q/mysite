SELECT
	id,
	user_id,
	obtain_name,
	obtain_mob,
	title,
	spec,
	address,
	CASE WHEN `status`= 1 THEN '付款'
			 WHEN `status`= 0 THEN '未付款'
	ELSE '发货'
	END AS 	`status`,
	quantity,
	group_concat(product)AS orders
FROM
	(
		SELECT
			business_order.id,
			business_order.user_id,
			business_order.obtain_name,
			business_order.obtain_mob,
			business_product.title,
			business_product.spec,
			business_goods.quantity,
			business_order.`status`,
			concat(
				business_goods.quantity,
				business_product.title,
				business_product.spec
			)AS product,
			business_storage.address
		FROM
			business_order
		LEFT JOIN business_storage ON business_order.storage_id = business_storage.id
		LEFT JOIN business_bulk ON business_order.bulk_id = business_bulk.id
		LEFT JOIN business_goods ON business_goods.order_id = business_order.id
		LEFT JOIN business_product ON business_product.bulk_id = business_bulk.id
		AND business_goods.product_id = business_product.id
		LEFT JOIN business_user ON business_user.recent_storage_id = business_storage.id
		AND business_order.user_id = business_user.id
		WHERE
			business_order.`status` = 1
		OR business_order.`status` = 0
		AND business_order.bulk_id = ?
		AND business_product.is_snapshot = 1
		AND business_order.is_delete = 0
	)af
GROUP BY
	id,
	user_id,
	obtain_name,
	obtain_mob,
	`status`,
	title,
	spec,
	quantity,
	address
