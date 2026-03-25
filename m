Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7270C3A6F1B
	for <gfs2@lists.linux.dev>; Wed, 25 Mar 2026 10:04:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774433098; cv=none; b=T0ximmHzxir38sSKGd4f7eJgroDysZG7zvAK7ZZTIzXLtsJooviIZZKB6qNu6lLcMm2N4TpL94HynDzlhPkZ04mwfTj7Tv1tauAHJUQ87A7mEOVP3REeXBHZ76yL/RudYMDTyahFuROrGOBMu008sBzVfoTlyQlGUAMyaMNuThY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774433098; c=relaxed/simple;
	bh=2pKvnpl7QsnL4W2KzfrlKMQo3poisxvLy6X9biBNzBg=;
	h=Message-ID:Date:MIME-Version:From:Subject:To:Content-Type; b=CZHajr0OQr7O2ErOgcjQav0p/2akgysTsdlYL2Z4yvy+Evj9CS+ne3hyM+UTrQ1tBeSDu7P23fr3o9VkPAGZY1/Jp+e7bxEjbQSLsp0eIvFZGkmgECW4HnySS7vbxMMKVWfwf5rjf6TSHWOtmI1k1mzPSFe46qzUE/99k3Ntl5g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=YrX5HZ8X; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="YrX5HZ8X"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1774433093;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=2pKvnpl7QsnL4W2KzfrlKMQo3poisxvLy6X9biBNzBg=;
	b=YrX5HZ8X0M9/znR6q7d2CTBV8pCg41w8OpfbNiNVYcUhuM+CUryIid7+jYoF3gAbWO1ejb
	HIYgDU4uaus2/Hs0EeOwk6YqoMVCx9/TOyD7BPZGKn1hpIf06Yzg8e7J/qLKIWicHL4d7N
	/3MqmCoWeejxYt3jHtx+s87gfNgdXLk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-375-fhJBPWMlObKC3oS_nJiP9w-1; Wed, 25 Mar 2026 06:04:51 -0400
X-MC-Unique: fhJBPWMlObKC3oS_nJiP9w-1
X-Mimecast-MFC-AGG-ID: fhJBPWMlObKC3oS_nJiP9w_1774433090
Received: by mail-wr1-f70.google.com with SMTP id ffacd0b85a97d-43b7ec737c1so2028585f8f.1
        for <gfs2@lists.linux.dev>; Wed, 25 Mar 2026 03:04:51 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774433090; x=1775037890;
        h=content-transfer-encoding:content-language:to:subject:from
         :user-agent:mime-version:date:message-id:x-gm-gg:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2pKvnpl7QsnL4W2KzfrlKMQo3poisxvLy6X9biBNzBg=;
        b=bAAPXUn7G0jXtU0dygBisoUY4o4ZwliPDY+6vkSQfrvhHnV6lOo3lzIRDnTY5frnWS
         XqLH/WVFucYAsJnePrfGHHz5/eLSXZeDSatoiqKjzkwnN6qXuRKjzoGBVqI5EyBjS6u+
         D98V9z86WfTVQAScKR8iggWUT0lX8BkIlw2S/O210g0u0d1R7oc+QQsJM6O/tJXUPe85
         fNGlBP3Fd69nZ7QpEiKqlW3hH/5UyW3PTNgFvq5JvJD9ESnrRE3XW2JQg5XsrLaJ6B6e
         XlBzWSnh6wyeRtrdOONAkZ0ehvAIGyhj95gKq+Lc7qeJnzVsBqPwT00s2EgKfmyEAcTF
         6qGg==
X-Gm-Message-State: AOJu0Yy1/ulCsmSKovDfZqYuCaLDyUo0bkYfqust9bJV83HJs6KJs26M
	90qqtnpZDYUMKF8FrcvSx384BYC6Lzo7cfaBKmZy6j+2BVkN+dnitEqAp/1anghlxDnHtFYm0ap
	BsfW8pJlXy+v5+mNLqgYy8Tbnc2Y9K3ObqC+J+qyuDtDu2L2XL88O8WjonW363MKT0AKG9bVbiH
	s0DU+mrKzK9LsisQhoxQEoDK+bqwwg948jfzIXvQ==
X-Gm-Gg: ATEYQzyp/2LJVkWEbDHNGIcpKDI0d6HbxNbcaY01YHSJ4Yhlq5fsnOzSPJycixA3Rrg
	z4zSFg2LgUTPxZu18TEL2L4RkOMUGTk7rVIVgWFE4IRJbsTMuaBGIZIMxH843ile3m0h7zzuKxg
	5dfRoSF3lC9RU1+jIRs8hDSdRoChZ9Zbw9VbSNkEXxyM7Y8DwrZIjsoNEFlKOysG7Ye+o2wjiUz
	nQ1gGVBYY2wOM7+SZBEDHpg5cKXMy/Hf5RlaOB04InTKDKF9/H6RXDzHdQXgcFuyTog3zU8DBpI
	IeljiNOt00pZtKZRzrsHjXmKNlR0TN5A3d1hpdWw5egJlu09vid8kdSEmX+1AFiv4wuIEoDve/b
	OiWyjb+7ZhfkJejJLenAxOlD52d7JtuQELlvhtnOKDV+GELrx3dUecW4pZmL3iHwEtxLyl7Sevd
	CD78rdag==
X-Received: by 2002:a5d:588a:0:b0:43b:86ce:27a6 with SMTP id ffacd0b85a97d-43b8898d428mr4216963f8f.9.1774433090314;
        Wed, 25 Mar 2026 03:04:50 -0700 (PDT)
X-Received: by 2002:a5d:588a:0:b0:43b:86ce:27a6 with SMTP id ffacd0b85a97d-43b8898d428mr4216912f8f.9.1774433089810;
        Wed, 25 Mar 2026 03:04:49 -0700 (PDT)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43b878a7b87sm7815904f8f.25.2026.03.25.03.04.48
        for <gfs2@lists.linux.dev>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 25 Mar 2026 03:04:49 -0700 (PDT)
Message-ID: <97d6101d-b6bd-4701-953c-8655eb91da11@redhat.com>
Date: Wed, 25 Mar 2026 10:04:48 +0000
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From: Andrew Price <anprice@redhat.com>
Subject: Heads-up: gfs2-utils.git and dlm.git will be moving
To: gfs2@lists.linux.dev
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: Fj4RFl4bRr4foLJ82XyCD4OiTf7Mrww7TzOz-P8ExmM_1774433090
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

Hi all,

Note: this relates to the gfs2-utils and dlm userspace projects. The kernel trees are not moving.

As pagure.io is being decommissioned in June, gfs2-utils.git and dlm.git will need to move to a different host fairly soon. The new location is planned to be gitlab.com based on the requirements of our CI infrastructure and on its familiarity to us RHEL/CentOS Stream developers.

As with the current host, if you don't have an account there to open MRs it will still be possible to submit patches to the mailing list. I will follow up with the final details when we know them along with instructions for updating your git clones to the new locations.

Cheers,
Andy

