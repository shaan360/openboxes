<%@ page import="org.pih.warehouse.inventory.Transaction" %>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
        <meta name="layout" content="custom" />
        
        <title>
            <warehouse:message code="${controllerName}.${actionName}.label"/>
        </title>
    </head>    

	<body>
		<div class="body">

			<g:if test="${flash.message}">
				<div class="message">${flash.message}</div>
			</g:if>

            <div class="yui-ga">
                <div class="yui-u first">
                    <div class="box">
                        <h2>
                            <warehouse:message code="default.filters.label" default="Filters"/>
                        </h2>
                        <div class="button-group" styl>
                            <g:link controller="inventory" action="listTotalStock" class="button ${'listTotalStock'.equals(actionName)?'primary':''}">
                                <warehouse:message code="inventory.listTotalStock.label"/>
                            </g:link>

                            <g:link controller="inventory" action="listInStock" class="button ${'listInStock'.equals(actionName)?'primary':''}">
                                <warehouse:message code="inventory.listInStock.label"/>
                            </g:link>

                            <g:link controller="inventory" action="listOutOfStock" class="button ${'listOutOfStock'.equals(actionName)?'primary':''}">
                                <warehouse:message code="inventory.listOutOfStock.label"/>
                            </g:link>

                            <g:link controller="inventory" action="listQuantityOnHandZero" class="button ${'listQuantityOnHandZero'.equals(actionName)?'primary':''}">
                                <warehouse:message code="inventory.listQuantityOnHandZero.label"/>
                            </g:link>

                            <g:link controller="inventory" action="listLowStock" class="button ${'listLowStock'.equals(actionName)?'primary':''}">
                                <warehouse:message code="inventory.listLowStock.label"/>
                            </g:link>

                            <g:link controller="inventory" action="listReorderStock" class="button ${'listReorderStock'.equals(actionName)?'primary':''}">
                                <warehouse:message code="inventory.listReorderStock.label"/>
                            </g:link>

                            <g:link controller="inventory" action="listOverStock" class="button ${'listOverStock'.equals(actionName)?'primary':''}">
                                <warehouse:message code="inventory.listOverStock.label"/>
                            </g:link>

                            <g:link controller="inventory" action="listReconditionedStock" class="button ${'listReconditionedStock'.equals(actionName)?'primary':''}">
                                <warehouse:message code="inventory.listReconditionedStock.label"/>
                            </g:link>
                        </div>
                    </div>




                    <div class="box">
                        <div class="right">
                            <g:link params="[format:'csv']" controller="${controllerName}" action="${actionName}" class="button">Download .csv</g:link>
                        </div>
                        <h2>
                            <warehouse:message code="${controllerName}.${actionName}.label"/> -
                            <warehouse:message code="default.showing.message" args="[quantityMap?.keySet()?.size()]"/>
                        </h2>
                        <table>
                            <tr>
                                <th class="center"><warehouse:message code="inventoryLevel.status.label"/></th>
                                <th><warehouse:message code="product.productCode.label"/></th>
                                <th><warehouse:message code="product.label"/></th>
                                <th><warehouse:message code="category.label"/></th>
                                <th><warehouse:message code="product.manufacturer.label"/></th>
                                <th><warehouse:message code="product.vendor.label"/></th>
                                <th class="left"><warehouse:message code="inventoryLevel.binLocation.label"/></th>
                                <th class="left"><warehouse:message code="inventoryLevel.abcClass.label" default="ABC Analysis Class"/></th>
                                <th><warehouse:message code="product.unitOfMeasure.label"/></th>
                                <th class="center"><warehouse:message code="inventoryLevel.minimumQuantity.label"/></th>
                                <th class="center"><warehouse:message code="inventoryLevel.reorderQuantity.label"/></th>
                                <th class="center"><warehouse:message code="inventoryLevel.maximumQuantity.label"/></th>
                                <th class="center border-right"><warehouse:message code="inventoryLevel.currentQuantity.label" default="Current quantity"/></th>
                                <th><warehouse:message code="product.pricePerUnit.label" default="Price per unit (USD)"/></th>
                                <th class="center"><warehouse:message code="product.totalValue.label" default="Total value (USD)"/></th>
                            </tr>
                            <g:each var="entry" in="${quantityMap.sort()}" status="i">
                                <g:set var="inventoryLevel" value="${entry?.key?.getInventoryLevel(session.warehouse.id)}"/>
                                <tr class="${i%2?'odd':'even'}">
                                    <td>
                                        <%--
                                        <g:render template="../product/status" model="[product:entry?.key,totalQuantity:entry?.value]"/>
                                        --%>
                                        <g:set var="status" value="${entry?.key?.getStatus(session.warehouse.id, entry?.value?:0 as int)}"/>
                                        ${warehouse.message(code:'enum.InventoryLevelStatus.'+status)}
                                    </td>
                                    <td>
                                        ${entry.key.productCode}
                                    </td>
                                    <td>
                                        <g:link controller="inventoryItem" action="showStockCard" id="${entry.key.id}">
                                            ${entry.key}
                                        </g:link>
                                    </td>
                                    <td>
                                        ${entry.key?.category?.name}

                                    </td>
                                    <td>
                                        ${entry.key.manufacturer}

                                    </td>
                                    <td>
                                        ${entry.key.vendor}
                                    </td>
                                    <td class="left">
                                        ${inventoryLevel?.binLocation?:""}
                                    </td>
                                    <td class="center">
                                        ${inventoryLevel?.abcClass?:""}
                                    </td>
                                    <td class="center">
                                        ${entry?.key?.unitOfMeasure}
                                    </td>

                                    <td class="center">
                                        ${inventoryLevel?.minQuantity?:"--"}
                                    </td>
                                    <td class="center">
                                        ${inventoryLevel?.reorderQuantity?:"--"}
                                    </td>
                                    <td class="center">
                                        ${inventoryLevel?.maxQuantity?:"--"}
                                    </td>
                                    <td class="center border-right">
                                        ${entry.value}
                                    </td>
                                    <td class="center">
                                        <g:if test="${entry?.key?.pricePerUnit}">
                                            <g:formatNumber number="${entry.key.pricePerUnit}" minFractionDigits="2"/>
                                        </g:if>
                                        <g:else>
                                            --
                                        </g:else>
                                    </td>
                                    <td class="center">
                                        <g:if test="${entry.key.pricePerUnit && entry.value}">
                                            <g:formatNumber number="${entry.key.pricePerUnit*entry.value}" minFractionDigits="2"/>
                                        </g:if>
                                        <g:else>
                                            --
                                        </g:else>
                                    </td>
                                </tr>


                            </g:each>
                            <g:unless test="${quantityMap}">
                                <tr>
                                    <td colspan="12" class="center">
                                        <div class="empty fade">
                                            <warehouse:message code="default.emptyResults.message" default="No results found"/>
                                        </div>
                                    </td>

                                </tr>

                            </g:unless>
                        </table>
                    </div>
                </div>
            </div>
		</div>
		
	</body>

</html>
