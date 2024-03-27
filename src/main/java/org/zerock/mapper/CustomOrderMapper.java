package org.zerock.mapper;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.zerock.domain.CustomOrderDTO;
import org.zerock.domain.ShopGoodsVO;
import org.zerock.domain.ShoppingCartVO;

public interface CustomOrderMapper {

	public int insertOrder_cus(CustomOrderDTO dto); //회원용 주문넣기(커스텀)
	public int insertOrderNomember_cus(CustomOrderDTO dto); //비회원용 주문넣기 (커스텀)
	
	
	public int insertOrder(CustomOrderDTO dto); //회원용 주문넣기(일반)
	public int insertOrderd_goods(@Param("orderno") String orderno, @Param("vo") ShopGoodsVO vo,@Param("model_name") String model_name , @Param("quantity") String quantity ); //회원용 주문 상품넣기(일반)
	public int insertOrderNomember(CustomOrderDTO dto);//비회원용 주문 넣기(일반)

	
	
	public ShopGoodsVO selectGoods(String gno); //상품코드로 상품정보 가져오기
	
	public int selectShoppingCartCount(long member_seq);// 유저시퀀스로 쇼핑카트 제품수 가져오기
	public int insertShoppingCart( @Param("vo") ShoppingCartVO vo); //쇼핑카드에 상품 넣기
	
	public List<ShoppingCartVO> selectCartList(long member_seq); //유저시퀀스로 쇼핑카트 리스트 가져오기 
	public int deleteCartElement(@Param("member_seq") long member_seq , @Param("cart_no") String cart_no ); //쇼핑카트 리스트 삭제 

}
