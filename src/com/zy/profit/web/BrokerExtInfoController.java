package com.zy.profit.web;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.zy.broker.entity.BrokerExtInfo;
import com.zy.broker.entity.BrokerInfo;
import com.zy.broker.service.BrokerExtInfoService;
import com.zy.broker.service.BrokerInfoService;
import com.zy.common.entity.PageModel;
import com.zy.common.entity.ResultDto;
import com.zy.common.util.UserDto;
import com.zy.common.util.UserSessionUtil;

@Controller
@RequestMapping("/boss/brokerInfo")
public class BrokerExtInfoController {

	@Autowired
	private BrokerExtInfoService brokerExtInfoService;
	@Autowired
	private BrokerInfoService brokerInfoService;
	
	@RequestMapping("/list")
	public String queryPage(BrokerExtInfo queryDto,PageModel<BrokerExtInfo> pageModel,Model model){
		
		model.addAttribute("page", brokerExtInfoService.queryForPage(queryDto, pageModel));
		model.addAttribute("queryDto",queryDto);
		
		return "broker/brokerExtInfoList";
	}
	
	@RequestMapping("/edit")
	public String edit(Model model,BrokerExtInfo entity){
		
		if(StringUtils.isNotBlank(entity.getId())){
			model.addAttribute("brokerExtInfo", brokerExtInfoService.get(entity.getId()));
		}
		return "broker/brokerExtInfoEdit";
	}
	
	@RequestMapping(value="/save", produces = {"application/json;charset=utf-8"})
	@ResponseBody
	@Transactional
	public ResultDto<BrokerExtInfo> save(BrokerExtInfo dto,HttpServletRequest request){
		ResultDto<BrokerExtInfo> result = new ResultDto<BrokerExtInfo>();
		try {
			UserDto userDto = UserSessionUtil.getSessionUser(request.getSession());
			if(StringUtils.isNoneBlank(dto.getId())){
				brokerInfoService.update(dto);
			}else{
				BrokerInfo brokerInfo = new BrokerInfo();
				brokerInfo.setName(dto.getName());
				brokerInfo.setExchangeNo(dto.getExchangeNo());
				brokerInfo.setCreateId(userDto.getId());
				brokerInfo.setCreateName(userDto.getUsername());
				brokerInfoService.save(brokerInfo);
				
				dto.setCreateId(userDto.getId());
				dto.setCreateName(userDto.getUsername());
				brokerInfoService.save(dto);
			}
			result.setSuccess(true);
		} catch (Exception e) {
			e.printStackTrace();
			result.setSuccess(false);
		}
		return result;
	}
}
