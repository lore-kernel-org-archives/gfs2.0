Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF4D377EA1;
	Tue,  7 Apr 2026 04:02:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1775534562; cv=none; b=nyGu3H7FoU5Hx8N/ZZXn0DmqAVBpDbCyNLOy5OD6ezy/zCc7n32xTFNgzNsFCWTrkXyIniQeetBcKgIX4jEBOUZGvFMy47aFtGSgsnov2CiewivvDRdW2cgDVXGzSYxc709Kn2pXlM4zk8joLoik5URFgsDElzEEwva1NJywGlw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1775534562; c=relaxed/simple;
	bh=LED1M7HVJEnh7AGs7pvZ+lbf7Dpp3Ogm2ZI7HRds+s8=;
	h=Date:From:To:Cc:Subject:Message-ID; b=DiUnXk4RGUoowGjqY6YPVT8EG+Gm+nkCYDjQ5vWDjYb2gMyKTWZjJs4S6CozztlsNEl3R7PF2lZXWlSTxyL6lRk8fWt4Hz/owVJzx+oslBbL48SIs/Hnx31KqxwLCGWPt7reA8GgntBzWACD4OCg7koH1Xp2jGCOynFogExVl6c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=A/a3ZtQk; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="A/a3ZtQk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1775534561; x=1807070561;
  h=date:from:to:cc:subject:message-id;
  bh=LED1M7HVJEnh7AGs7pvZ+lbf7Dpp3Ogm2ZI7HRds+s8=;
  b=A/a3ZtQkNNHwrwQRmMO7G9gbkjPseWrPWh8r7TYhv8aXIRLgws8l0VnO
   ecFMF4e+sYkxeOGdSKp5fGE1jOWsV7XyDlS/nLnfATPvWFwgG0+wOPpx1
   H/MnGJJdFgX1+DLKfn+bDE79JRKheKdxCqjWMBGurZB4u10MsYjb5c6C4
   bhMTP++Kottz/G0e3wzAhJ4f3/A1asyylrhxh8NNala8hR8uWfNBagQVL
   n2XeGOWjhcEaH9OKaDbXDXuQFzxMaNuHqbgbvp6piFprIbNSHnvnfXVrc
   bc2rFftLMDlmim7wdX86K5tir9Ctuf6Go5PPG8m10UBEOBSIbS35+luOR
   g==;
X-CSE-ConnectionGUID: j+QVECE7Se+q3b66gFqBzg==
X-CSE-MsgGUID: OLTB77hgTJ2OtS74hWcY4A==
X-IronPort-AV: E=McAfee;i="6800,10657,11751"; a="76386028"
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="76386028"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Apr 2026 21:02:38 -0700
X-CSE-ConnectionGUID: AIWNgey7TtqEt2rwUcKizQ==
X-CSE-MsgGUID: f5xHzYLORlmmlb6cfGxF7A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,164,1770624000"; 
   d="scan'208";a="227957164"
Received: from lkp-server01.sh.intel.com (HELO d00eb8a6782a) ([10.239.97.150])
  by orviesa009.jf.intel.com with ESMTP; 06 Apr 2026 21:02:36 -0700
Received: from kbuild by d00eb8a6782a with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1w9xe5-00000000089-3g7L;
	Tue, 07 Apr 2026 04:02:33 +0000
Date: Tue, 07 Apr 2026 12:02:05 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, gfs2@lists.linux.dev
Subject: [gfs2:for-next 14/17] Warning: fs/gfs2/log.c:1013 function
 parameter 'sdp' not described in 'gfs2_trans_drain'
Message-ID: <202604061030.jP5nGGmm-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git for-next
head:   80d71795c17ec98352d1059af856ac084a06109a
commit: 6f73942add5d404f56f70bdccd3d3c6b11488469 [14/17] gfs2: gfs2_log_flush withdraw fixes
config: nios2-allmodconfig (https://download.01.org/0day-ci/archive/20260406/202604061030.jP5nGGmm-lkp@intel.com/config)
compiler: nios2-linux-gcc (GCC) 11.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260406/202604061030.jP5nGGmm-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202604061030.jP5nGGmm-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/gfs2/log.c:1013 function parameter 'sdp' not described in 'gfs2_trans_drain'
>> Warning: fs/gfs2/log.c:1013 function parameter 'sdp' not described in 'gfs2_trans_drain'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
