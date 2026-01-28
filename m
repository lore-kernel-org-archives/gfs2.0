Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6167034575F;
	Wed, 28 Jan 2026 23:15:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769642152; cv=none; b=upfeQaGoz+gBM7FZbkGfobTvbY8Nnur11UTN7CxvXTQEKxR4Pwu7m+4g5jptEEgwtQOO4uj9gY65PcogVpDbuOZnsUUxDCPENuLPW21N3CNwYrii2ffHjvD6WgxK8EJ35EQi4KEhTy13bSAIqMNPdBsB/y9pFLX3IeN28klVhGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769642152; c=relaxed/simple;
	bh=1jFlQQO8A+HMcYzsLtZzBxrY5nhSTOhny13PpycHMzw=;
	h=Date:From:To:Cc:Subject:Message-ID; b=fDidZHB4dbCk9YHx63CUM1Tanytr8Fn+A/+Z8L6LV33r2xphwgfhljL7mL+VlJBIe9dhO2mGIKIY6K6KNztJ7C+gd+9/sYacVMYx6OOEix47UIPoxnX77VmANP8YnzZrMO9XSNjkOimuJhi3bjzPsjdm30CFlJUvSYAi3xNByDI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FbMO6uma; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FbMO6uma"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769642151; x=1801178151;
  h=date:from:to:cc:subject:message-id;
  bh=1jFlQQO8A+HMcYzsLtZzBxrY5nhSTOhny13PpycHMzw=;
  b=FbMO6umahngHw2SBFfAiSrIeHY0FAVHjknccV25TT96QTpe9X/JCvO52
   vqPqMBIj9eT7ytR0jZ9DGl1j+jpv/ovTkkaLvT/c/jgPriqI3s3IuC1R2
   9lOTisi1URdqraldcBoneVB1ZOTPkYFj04W2RRphiKDKVVJlYmnvkfOav
   wyvzRPahhN3QxKJ/8AO4wIZNWozpv9W8NQizGY7NTIKYgyw7MrzJE9now
   9juqrye7EesOrqLzefB3zQDhr6pI/Q39hKXzA1CG6NJNxM3l2YGssaGsU
   3MbJSUgh11Reehw87JNJiVOATkNL7+x8Y/qwrfbttgP1VqCgaigbAdHTk
   g==;
X-CSE-ConnectionGUID: ijbu0a+aS8++7UQjNk+wVw==
X-CSE-MsgGUID: 6+8lOZDMT5yQe2Zh4hwKwQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="73462174"
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="73462174"
Received: from fmviesa004.fm.intel.com ([10.60.135.144])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 15:15:51 -0800
X-CSE-ConnectionGUID: MAqeHauTQySHyRfQaJx0Dw==
X-CSE-MsgGUID: T4qXbDXgQlmuzHVDoM5nkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,258,1763452800"; 
   d="scan'208";a="213266490"
Received: from igk-lkp-server01.igk.intel.com (HELO afc5bfd7f602) ([10.211.93.152])
  by fmviesa004.fm.intel.com with ESMTP; 28 Jan 2026 15:15:49 -0800
Received: from kbuild by afc5bfd7f602 with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlElH-0000000027h-25oJ;
	Wed, 28 Jan 2026 23:15:47 +0000
Date: Thu, 29 Jan 2026 00:14:54 +0100
From: kernel test robot <lkp@intel.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, gfs2@lists.linux.dev
Subject: [gfs2:bufdata 13/13] Warning: fs/gfs2/log.c:994 function
 parameter 'sdp' not described in 'trans_drain'
Message-ID: <202601290029.ITT7Edfu-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git bufdata
head:   e4483c611981a48e12166c1b2845773dafd7de52
commit: e4483c611981a48e12166c1b2845773dafd7de52 [13/13] gfs2: per-filesystem bufdata
config: x86_64-rhel-9.4-ltp (https://download.01.org/0day-ci/archive/20260129/202601290029.ITT7Edfu-lkp@intel.com/config)
compiler: gcc-14 (Debian 14.2.0-19) 14.2.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260129/202601290029.ITT7Edfu-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601290029.ITT7Edfu-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/gfs2/log.c:994 function parameter 'sdp' not described in 'trans_drain'
>> Warning: fs/gfs2/log.c:994 function parameter 'sdp' not described in 'trans_drain'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
