Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60C3848096F
	for <gfs2@lists.linux.dev>; Thu,  2 Jul 2026 12:51:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782996701; cv=none; b=LYO+0qG0BBMBywLuutySlgNtKFbUckgYE1H31M3iW5hSlyQOp6cw3q+3yrYa5OjVz2Zt9sVLTvhiTfhmYg4zKaOfHjlzWXA2VpKDTfkYXsb8cF0ReyFlxDSGYFgXl1ZwdFCY0XeqJRymTs1C8/f8Ap6JI3vJvhluD/SA8ClXft0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782996701; c=relaxed/simple;
	bh=QauJfK7TQ4IMu5sktW06gXbrR3ydEPMq/vaTL/7KD+8=;
	h=Message-ID:Date:MIME-Version:Subject:From:To:References:
	 In-Reply-To:Content-Type; b=X+nt1/ykw+hr8Yc+S20r1VZiZE4/eUsRcUA0gk4Yqszkkh2xMzHa6y25cRMLCiQ+0APVLnJvaLynhsTzjqrvxBuoBIRa0K9bigxJ/wwUg14tA0EYLTyT2uZ79x559k1PLPXWy9jEv8d65qsR4Vb660hOBsEEcE4cwKz3VHBYbvY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VxtsKBd4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VxtsKBd4"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1782996699;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=+7tSbrQ1yX/y6RQo9XaFBygzer4ywLgL2odQvomGO0k=;
	b=VxtsKBd4IKgoHFU6Fa6u3P+QO9FefhrcwfyO55mhuoaGQ9MqygrnRxR9Pk5CJDOqG8N8WN
	Q0YxNRhKjcC4aI3f7vfnVENFuecrHRnxj3NO/aPG+51TfN8fQ4ig4GwbZEexlkW47T0DHq
	4+Q0C3QC99t8yOoThNLQ3l4Ae3ZEVWw=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-608-U4aEZyQpNlaP4o1ZZ0D9Ig-1; Thu, 02 Jul 2026 08:51:38 -0400
X-MC-Unique: U4aEZyQpNlaP4o1ZZ0D9Ig-1
X-Mimecast-MFC-AGG-ID: U4aEZyQpNlaP4o1ZZ0D9Ig_1782996697
Received: by mail-wm1-f70.google.com with SMTP id 5b1f17b1804b1-493bc2b376fso9290365e9.3
        for <gfs2@lists.linux.dev>; Thu, 02 Jul 2026 05:51:37 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1782996697; x=1783601497;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :to:from:subject:user-agent:mime-version:date:message-id:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+7tSbrQ1yX/y6RQo9XaFBygzer4ywLgL2odQvomGO0k=;
        b=nwwWAYKJBgB0wv5arwa6U6r5By+eIFNWvZOwp25RNevSns5snabNVfDvV5F+vk1F0O
         IErcRMMJ9poqt1xJkECOjjF/SYZOI1L9d56zKRUdy7SQfg2DcNOlCHiIWYzlIYbz0gzr
         2345Ze+e2zHi1lWohcp9ZEciX1WxrWer7Jx1aFYWGqh3FvMTXipKMi3RpehS74OFBpqE
         TjymBUT4UQNaPjVzsn8xRJd8iDHeJy1RnQdYxnHKWCU4OLc6zuE+WssWZXTZmn3pMvCF
         LJTxqMXniMsHi2s/9zRFDU7sqvciSTxyScdXAIBOYfODAFSBHPnuCepx3RSGoAd8V72M
         5Nxg==
X-Gm-Message-State: AOJu0YwzSXqABR9uQfBQ39eWZ+YN7N9+yzdp7OLevGlyOjRHWBxFI5Sb
	ZfWJVqX7xtF8TfquhC4xDcgk6UyeHDzQ+tR9Hj6QMLxerRswNwZDY5dMGkaqXykrasfU5qHD+fD
	Aoo22CjILtN0cOpjm0BXq2v/koTBM9SELmO06vMqXJAFTjzl2pyPa3TlN5DuZwFdJpY/P6EwrC8
	NyjN53LLWCGWWCuxxbR/9taaC73sO4+h7Uyl/jWQ==
X-Gm-Gg: AfdE7cl9hYbU3q3wuaHQl0zEY+kAoOFcvPwtFmhfIUhGou+VvJ9x8QcnHz3V+t/11AI
	Mgrlq46WhMYHLBTCP6X9FwXry7ERDlpdPUp8jGcbp9nxU0GFMUIPzrk/AxgqlfPfjSS2amaee0i
	54tsid7CAeRQbVe5mqoXnJVcgpCUPIBJVlmndQt2fGU6lcQDQZ+1/OCpcAe8junlGoxyeeE1X+G
	F7Dqs2W8alu9asKBpDHAF0yJmuKwWj8q5Q3fqB3cEjCJyjSK2tZmgCkKg02XA1/7mPPuIghmR1Q
	TlkV8Q0lJE7UuNSC9guFehYlObgeUiNW2NX9XFmQ1UmMrdnNEpK/Xmgi4E2ZBs2VA8iAWDk/ZDN
	BsaxfJJTnGWJs+r68YBmkWo2BACu85o36L9msBQ2YfHnxJTskF0dMriFwuBz2Vi/KkLtMd0c=
X-Received: by 2002:a05:600c:34d4:b0:490:5057:f5f7 with SMTP id 5b1f17b1804b1-493c2b4a99bmr80457895e9.11.1782996696865;
        Thu, 02 Jul 2026 05:51:36 -0700 (PDT)
X-Received: by 2002:a05:600c:34d4:b0:490:5057:f5f7 with SMTP id 5b1f17b1804b1-493c2b4a99bmr80457385e9.11.1782996696410;
        Thu, 02 Jul 2026 05:51:36 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-493bef183e7sm153174465e9.2.2026.07.02.05.51.35
        for <gfs2@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Jul 2026 05:51:35 -0700 (PDT)
Message-ID: <d4dfee66-ec36-4f93-b709-dea26651fe43@redhat.com>
Date: Thu, 2 Jul 2026 13:51:35 +0100
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Heads-up: gfs2-utils.git and dlm.git have moved
From: Andrew Price <anprice@redhat.com>
To: gfs2@lists.linux.dev
References: <97d6101d-b6bd-4701-953c-8655eb91da11@redhat.com>
In-Reply-To: <97d6101d-b6bd-4701-953c-8655eb91da11@redhat.com>
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: GbVSUp37qMYB6ui2wKSyPwpy9G722xdUOKu1LJ76ID4_1782996697
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

This is a follow up to let you know that the gfs2-utils.git and dlm.git (userspace) repositories have now moved.

The new project landing pages are:

  https://gitlab.com/linux-gfs2/gfs2-utils
  https://gitlab.com/linux-gfs2/dlm

The new git URLs are:

  https://gitlab.com/linux-gfs2/gfs2-utils.git
  https://gitlab.com/linux-gfs2/dlm.git

Please re-clone or update your existing git trees to use these URLs, e.g.

  $ git remote set-url origin https://gitlab.com/linux-gfs2/gfs2-utils.git

Similar to before, we will accept pull requests via GitLab or via the mailing list (in which case we can create a PR ourselves to make sure the patches pass CI testing).

Release tarballs will now be available at:

  https://gitlab.com/linux-gfs2/gfs2-utils/-/releases
  https://gitlab.com/linux-gfs2/dlm/-/releases

As Pagure's hosting of the release tarballs is also going away, we've uploaded the historical releases there, too.

Thanks,
Andy

On 25/03/2026 10:04, Andrew Price wrote:
> Hi all,
> 
> Note: this relates to the gfs2-utils and dlm userspace projects. The kernel trees are not moving.
> 
> As pagure.io is being decommissioned in June, gfs2-utils.git and dlm.git will need to move to a different host fairly soon. The new location is planned to be gitlab.com based on the requirements of our CI infrastructure and on its familiarity to us RHEL/CentOS Stream developers.
> 
> As with the current host, if you don't have an account there to open MRs it will still be possible to submit patches to the mailing list. I will follow up with the final details when we know them along with instructions for updating your git clones to the new locations.
> 
> Cheers,
> Andy

