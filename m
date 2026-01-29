Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.8])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5660C37998A;
	Thu, 29 Jan 2026 07:07:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.8
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769670462; cv=none; b=KWtmeHY4cccBV7wu4NdmV6Sib4YjNuiHvJtH2MrzrQW+1LGergspfIx+fXLm8fDBR1AFmZb6DGc5I8dbVQSx00dR4+kt1lsOfqkbjHtTQ+qaepanD12qRbGmiE21uM4fDN0QiGCgbfwrVNZQurat1mNhNbZ0bA5wlBvFV6r337k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769670462; c=relaxed/simple;
	bh=79Ob+0kE12R6Uti0WJjfey0zVs+v9YDo6w38AHHbRwc=;
	h=Date:From:To:Cc:Subject:Message-ID; b=tPNa1nddkCdQd3/eONngnPuNuvpsPCI0+/eaPhLLnGDAdgLYp0L5ovww9mSULxAD5OtH9aNVEJs6TVVoOcxbEiTTPoOcp0I63Hd4TH/IH764bnH2wAR19pl6RA3SjuBjWoWQpJblMj4b8f6Lkwq/x02GTEgXFY1Md5P2NnsVD0k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=FZVLzOyB; arc=none smtp.client-ip=192.198.163.8
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="FZVLzOyB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1769670462; x=1801206462;
  h=date:from:to:cc:subject:message-id;
  bh=79Ob+0kE12R6Uti0WJjfey0zVs+v9YDo6w38AHHbRwc=;
  b=FZVLzOyB3aOThmrGNovU05mHtnltU3XR8OzZXqIO1FbXdlVttzIUPRb7
   SEBsb5TBM5LHB5RmpjJBNn4b2yIXTfrvUu3jMwVwKK2ginbNeX+T2GXWt
   pvRyeFkgZmksDfGIHT+VS3veuTwO0mglJMFDJaYhBwFlOVou9Mkd4PvE1
   nvohEDB6AsO23o2hCB/pI/LqrbaUvi+bSReTcv+DELtrnRwoN31qgqAm8
   f0fV1ig8TcZgGCka6t/yj+uxglvYBhjStzIzeBz35eZAFyBl9qFK9ADQN
   lP75wOdLfQraiOcvzG8cHWNqDPrKyJI7q9ufgjmCfACzURhoGy4z60k2X
   A==;
X-CSE-ConnectionGUID: +EOmDeSiR5isQ9Dkzl09HA==
X-CSE-MsgGUID: 57cKSwN8R7yh8NUaqaCUBw==
X-IronPort-AV: E=McAfee;i="6800,10657,11685"; a="88473648"
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="88473648"
Received: from fmviesa008.fm.intel.com ([10.60.135.148])
  by fmvoesa102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jan 2026 23:07:41 -0800
X-CSE-ConnectionGUID: b4X4BLozTGOkLFmalRY/9Q==
X-CSE-MsgGUID: 9YNuJtYZS1KoICjPTonDkw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.21,260,1763452800"; 
   d="scan'208";a="208730308"
Received: from lkp-server01.sh.intel.com (HELO 765f4a05e27f) ([10.239.97.150])
  by fmviesa008.fm.intel.com with ESMTP; 28 Jan 2026 23:07:39 -0800
Received: from kbuild by 765f4a05e27f with local (Exim 4.98.2)
	(envelope-from <lkp@intel.com>)
	id 1vlM7t-00000000bC6-1dMO;
	Thu, 29 Jan 2026 07:07:37 +0000
Date: Thu, 29 Jan 2026 15:06:46 +0800
From: kernel test robot <lkp@intel.com>
To: Andreas Gruenbacher <agruenba@redhat.com>
Cc: oe-kbuild-all@lists.linux.dev, gfs2@lists.linux.dev
Subject: [gfs2:bufdata 13/13] Warning: fs/gfs2/log.c:994 function
 parameter 'sdp' not described in 'trans_drain'
Message-ID: <202601291537.4Vu4TCu0-lkp@intel.com>
User-Agent: s-nail v14.9.25
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/gfs2/linux-gfs2.git bufdata
head:   e4483c611981a48e12166c1b2845773dafd7de52
commit: e4483c611981a48e12166c1b2845773dafd7de52 [13/13] gfs2: per-filesystem bufdata
config: parisc-randconfig-002-20260129 (https://download.01.org/0day-ci/archive/20260129/202601291537.4Vu4TCu0-lkp@intel.com/config)
compiler: hppa-linux-gcc (GCC) 8.5.0
reproduce (this is a W=1 build): (https://download.01.org/0day-ci/archive/20260129/202601291537.4Vu4TCu0-lkp@intel.com/reproduce)

If you fix the issue in a separate patch/commit (i.e. not just a new version of
the same patch/commit), kindly add following tags
| Reported-by: kernel test robot <lkp@intel.com>
| Closes: https://lore.kernel.org/oe-kbuild-all/202601291537.4Vu4TCu0-lkp@intel.com/

All warnings (new ones prefixed by >>):

>> Warning: fs/gfs2/log.c:994 function parameter 'sdp' not described in 'trans_drain'
>> Warning: fs/gfs2/log.c:994 function parameter 'sdp' not described in 'trans_drain'

-- 
0-DAY CI Kernel Test Service
https://github.com/intel/lkp-tests/wiki
