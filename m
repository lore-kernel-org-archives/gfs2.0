Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com [209.85.221.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4608F266B46
	for <gfs2@lists.linux.dev>; Thu, 14 Aug 2025 07:39:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755157178; cv=none; b=ShoPX2lKiahq0a7po4f4Z4SSR5qm6ykwjD1wKgcQTp4Jkj/2E5tp3EUcdkPPjeK7a9bmiaklyiiU0ybGswlnNpiH0FlZDx94q7YZjH1a+5ujjMDIaQ6iAI13Bgtu3fuTccrhL6iAyWV6T7YUXLtfOomliZWlP+/b72xYWDlsoiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755157178; c=relaxed/simple;
	bh=ALEyWB/YvSIOqNT/FqLWvuSL26cPS6ygVKdATykF3Po=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition; b=a/6PJooSJngwm/sfOtLfMbdNObqGWJG3KKHgVF9YvJ2iCrCvkzn221N3tz1lPpfsT4eVCqDkfOtpQ0N9lLzlkz1S8TgBvbmUzDrD37b5yaeiu3le0wkQjQXMcE0zUZhulVQiaPJsjtfFGG92N3Xm+wdNNFS15BzXBzidMhjaDUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nR1xhUJf; arc=none smtp.client-ip=209.85.221.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nR1xhUJf"
Received: by mail-wr1-f54.google.com with SMTP id ffacd0b85a97d-3b9e4106460so470767f8f.2
        for <gfs2@lists.linux.dev>; Thu, 14 Aug 2025 00:39:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1755157174; x=1755761974; darn=lists.linux.dev;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3j3o/uM6s00VZXsZJJ6rbfxvmzIgHukCm/updFmGtnU=;
        b=nR1xhUJfMBvPSRjVdn7nkiD8hvX1nmVMcLe/+eRSQwZtGL9FiyClA/5/59NCyycb4n
         BFuLMgjBMrq5cMZ+guUvJmG0pq1t7MSLOFLLIJqi/bGuhx/azdtMOEP1fD6/D168APFD
         mcZl8KMlfILdXXU7i+IWrs5lMeraZuRHK751RJp5oeSwG57hHpO2Wj/gTouDHdIObz1U
         QoRBJDnLlup8mnpqdEcaoGgsaifrFIH2gVN2NNqj/nfgxrlMyT7JZCxtT+gCavFwSCBV
         E1YjjjKPDUt8q5Fb1Un8R8mLLIoiTA1u0t1bVL+D7dvTyXslVSiy1jWIn0OEpXAehhQl
         GuMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1755157174; x=1755761974;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3j3o/uM6s00VZXsZJJ6rbfxvmzIgHukCm/updFmGtnU=;
        b=MWQeMh/HonIjA0GZgco5jH7fdLfigsG1/zZlwxgQ/IY+mb78tPP2qVKO3A8Tg1wQd/
         xCfmhq8uFfQMFpyc9ZUFbRgon9kW41EioNTA6PCYOIb9daWcC9mI/mIQChwixk1M0A7w
         EoXqG1hGF6jfZKP4K66V/wNsXSrSdHoyPVDKlzmLQkBfcN1y/Bh2eV6SBhH72bVLbZBw
         YhxNWwOArXwkCM0NvKI/ngbZwk3gnmsClE84z92edcw7C5Vnqe2ae9WgRcGk466geh9e
         dsr7+HmIuljSPYSVyZIRkxbH69DuyVmMR0cYdgHiDdJbthbNqi4xL30gKFzo6vu/Rin2
         eKMA==
X-Gm-Message-State: AOJu0Yy4VrqpWs0HzVOHG8U1WHTHci9T9TpKxTzDt52KBwG2Hsm9SauV
	iae0QtGjI4IS5Y2xRNrmwi3+mVchs+aRsSUvcNyjbLvO/ZXYF4AVc0I49cKM1VLPxbYAT6tk7N+
	dKJJm
X-Gm-Gg: ASbGnctGrrUs18yoViTxWJpQA7PXkb/iqzbHX+2CSSti7lLMOu1BGrEjPsN/4WvIHTK
	iNG3SoL6C70B5BaItQo/KP5f/F01VwyEzp/8n4zFnFU595nFdbU/ygSEUs/6/2DNhZhcLfYhugF
	i5CamGbJoCQRWln8dFuvgjM9uQL2bPfdWZCaWOz60DisMnquq+OMGcrEy8WGOd+bgdNkQARwiVY
	HELLX6KhblQ4M758aYzjrzMs9T1ksx5A05mrai6Uz6304jXcMoCSbnxM8WytWxxC0FICX+GNXhk
	HfgTT56mHUjz32YsYBA7zYW2vtSCxK/b+irTnf/z5L94HJpRpZh2vCqKtZXhbXfdRqnofRcNCaF
	M2aivNCW9h6Tq7QEuN3XMr/o/i3o=
X-Google-Smtp-Source: AGHT+IE9saZjPrYP/p9QurYbQuy1T1+blYUUgAAzKXrXDPbeMdnK6KscxIidmyjE8F5upzBXwPqgkg==
X-Received: by 2002:a5d:5f53:0:b0:3b9:1443:aba with SMTP id ffacd0b85a97d-3b9e4159f7fmr1657137f8f.9.1755157173953;
        Thu, 14 Aug 2025 00:39:33 -0700 (PDT)
Received: from localhost ([196.207.164.177])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-3b8fc28a830sm26152157f8f.16.2025.08.14.00.39.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Aug 2025 00:39:33 -0700 (PDT)
Date: Thu, 14 Aug 2025 10:39:30 +0300
From: Dan Carpenter <dan.carpenter@linaro.org>
To: Alexander Aring <aahringo@redhat.com>
Cc: gfs2@lists.linux.dev
Subject: [bug report] dlm: add new configfs entry release_recover for
 lockspace members
Message-ID: <aJ2Ssuh8xlsTutrA@stanley.mountain>
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hello Alexander Aring,

Commit de7b4869b4ec ("dlm: add new configfs entry release_recover for
lockspace members") from Jul 23, 2025 (linux-next), leads to the
following Smatch static checker warning:

	fs/dlm/member.c:579 dlm_recover_members()
	error: we previously assumed 'node' could be null (see line 574)

fs/dlm/member.c
    551 int dlm_recover_members(struct dlm_ls *ls, struct dlm_recover *rv, int *neg_out)
    552 {
    553         struct dlm_member *memb, *safe;
    554         struct dlm_config_node *node;
    555         int i, error, neg = 0, low = -1;
    556         unsigned int release_recover;
    557 
    558         /* previously removed members that we've not finished removing need to
    559          * count as a negative change so the "neg" recovery steps will happen
    560          *
    561          * This functionality must report all member changes to lsops or
    562          * midcomms layer and must never return before.
    563          */
    564 
    565         list_for_each_entry(memb, &ls->ls_nodes_gone, list) {
    566                 log_rinfo(ls, "prev removed member %d", memb->nodeid);
    567                 neg++;
    568         }
    569 
    570         /* move departed members from ls_nodes to ls_nodes_gone */
    571 
    572         list_for_each_entry_safe(memb, safe, &ls->ls_nodes, list) {
    573                 node = find_config_node(rv, memb->nodeid);
    574                 if (node && !node->new && !node->gone)
                            ^^^^
So "node" can be NULL

    575                         continue;
    576 
    577                 release_recover = 0;
    578 
--> 579                 if (node->gone) {
                            ^^^^^^^^^^
unchecked dereference

    580                         release_recover = node->release_recover;
    581                         log_rinfo(ls, "remove member %d%s", memb->nodeid,
    582                                   release_recover ? " (release_recover)" : "");
    583                 } else {
    584                         /* removed and re-added */
    585                         log_rinfo(ls, "remove member %d comm_seq %u %u",
    586                                   memb->nodeid, memb->comm_seq, node->comm_seq);
    587                 }

regards,
dan carpenter
