Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D540221554;
	Tue, 19 Aug 2025 15:40:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755618003; cv=none; b=oPdxQ3GVCk1Gy3ATlOM3eV2NE30o2hCcwKQPsVjOebKs0rQf0jdW6dmQRzCQPF/k555AIqRivMkPwUfGi92Zds89nslfBXkNJiKz3lkbxAFmJWZy8Qwns/o2ZiHFmH/l66rhvhQ5WGvn0uOfEmO0eKsKK2E9bIbIxXYZ8ddvKFw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755618003; c=relaxed/simple;
	bh=9pUWyFteY2nnPC2aHmLrc8AjDMqad0OxDHJPM0fCnmI=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=QWKLQQor3LZfnrR2oOqHoci6pBsXfAkGQpqXoHxcDDFT5q40gmib8BkmVUsIbRqvGiiC3hauc6/xoq8rVmVrHccS2BnzxTdwcH2aswq08TdQiQ4aovm5RJk5jdffk+ZUFHMj8v7QbOgK615rWHmINrNRC6mwCBKoK7Wb2mWs0Nc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LRi/itzH; arc=none smtp.client-ip=198.175.65.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LRi/itzH"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1755618002; x=1787154002;
  h=date:from:to:cc:subject:message-id:mime-version;
  bh=9pUWyFteY2nnPC2aHmLrc8AjDMqad0OxDHJPM0fCnmI=;
  b=LRi/itzHwPm9f9sNxTI5WpBzsSmILjCidizQz8p4dDkSmpkEXJi0ME2O
   B32aQKCvKHecaivnzUnhUvvKj01pWuK5ERyAqdGEwd5gQ6vorEeB3YAXU
   lW7kxsPyYas+p3PdzbpdznZIhh32kDHqePtu0aduH/htgnOW40CHxCVp2
   bDitO0DkdtZYQBU9liZQv/55JpGbuc6nHJ0Nv93vsz7JOWo+FHhSG30jI
   cqbYB3+Sd9hpkvxwJ2oqVCuMhKPbFubbpR0JwEKdi+B9KFOVG7d9caKxx
   B2o1yxXdTEFGQ0zrQrfrgC4B/797rIGxsvLYFvesM/Ggd6C5CUhKhjVrX
   A==;
X-CSE-ConnectionGUID: tMTKcSA3Snq0o435mz7yeA==
X-CSE-MsgGUID: ZGA0ZTv3QKOWtUzAAJaASQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11527"; a="57820385"
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="57820385"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa109.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2025 08:40:02 -0700
X-CSE-ConnectionGUID: RwoSPPE+SsGErMfhjRmS7g==
X-CSE-MsgGUID: phGiBBDmRRCN0JZL/yfvkQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.17,302,1747724400"; 
   d="scan'208";a="172115078"
Received: from lkp-server02.sh.intel.com (HELO 4ea60e6ab079) ([10.239.97.151])
  by orviesa003.jf.intel.com with ESMTP; 19 Aug 2025 08:40:00 -0700
Received: from kbuild by 4ea60e6ab079 with local (Exim 4.96)
	(envelope-from <lkp@intel.com>)
	id 1uoORJ-000H4X-29;
	Tue, 19 Aug 2025 15:39:57 +0000
Date: Tue, 19 Aug 2025 23:39:15 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, gfs2@lists.linux.dev
Subject: [gfs2:withdraw 41/41] Warning: fs/gfs2/util.c:177 function parameter
 'sdp' not described in 'gfs2_offline_uevent'
Message-ID: <202508192353.eNviihQb-lkp@intel.com>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git withdraw
head:   802303d527a0ea007b50ec4b807c3043e6f1ae5e
commit: 802303d527a0ea007b50ec4b807c3043e6f1ae5e [41/41] gfs2: New gfs2_withdraw_helper
config: sh-randconfig-002-20250819 (https://download.01.org/0day-ci/archive/20250819/202508192353.eNviihQb-lkp@intel.com/config)
compiler: sh4-linux-gcc (GCC) 15.1.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20250819/202508192353.eNviihQb-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202508192353.eNviihQb-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/gfs2/util.c:177 function parameter 'sdp' not described in 'gfs2_offline_uevent'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
