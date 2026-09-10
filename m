Received: from mail-ed2-f12.google.com (mail-ed2-f12.google.com [74.125.228.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE05549BD80
	for <gfs2@lists.linux.dev>; Thu, 10 Sep 2026 15:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.76
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789053874; cv=pass; b=MLetkyIE8yvZy4guLLNJOLzwP1YCOs09FGkGdJbcmPBeX6Q7Yvat5jWsRhm7R4yBhkPSkVhef4O75fOCHgOuIuNA2i6igVLcilwP18p7Md2CuMzULv6L1WXFFU/fDbT6jgRM6N+JE+HTDr+9aiF6kYX6cQ6ufDhqALOfG8vSWAs=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789053874; c=relaxed/simple;
	bh=9VQjJt6a+185GkYjPMQmDeyCxl5xt0e29jz5LgzWiBs=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=kZlSTDyufB7wXnlGsAc8VonuRTQfQhxodBvhlN+pIHA96ipa//1+zydLNZrSn4iaANQ5w45LNm47Yh/bl7ShZEf2CcQM4uSIgJKHiNrxDNTW5wS5GQoBgEtaf4nWGPAo1AZ7EcM+wh/Ldt3OyqlmEWyHmVpOWeYWg1doioJA7QE=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=iyZfODGG; arc=pass smtp.client-ip=74.125.228.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iyZfODGG"
Received: by mail-ed2-f12.google.com with SMTP id 4fb4d7f45d1cf-6a67fa7a64eso2511268a12.1
        for <gfs2@lists.linux.dev>; Thu, 10 Sep 2026 08:24:32 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1789053871; cv=none;
        d=google.com; s=arc-20260327;
        b=quANAwmJYTwmttbqq2VWzGzdZQ4u86giOhrPUT06cDxM7Jy6VQujwsoGVng8/KJCbW
         kgr/R84HQlXty5WSYVMURVGYuYA1zLmPhn0V9tbWty11kEdECufElfI7sf2sD5IT/Hsu
         fKvryw4zJ6TNtdsHJwY8za2CllQQekQZjRw8xTKZ1ykP5x8sX83tHFa9mreAjo4wE4l6
         RtPKouw4EEE0s081plVj8lXY/JXep+pQTY+lppYRvOiplxzlTWaglfWjzJ0KxjN2W87u
         riuPrrMM+btom5LVMb59lDiMf88bSiq1b4aC2vLRmtcvMFrorYfElDwh+yZWXVwIYbnx
         V1/w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:dkim-signature;
        bh=W02XYVTB0Nl5fojAG5hBMBTOksfDYePfH5xC6TePd8A=;
        fh=dBS10QUCCufVxgeQ/0uruUc3UXLWAcDTQhb6GxizaeE=;
        b=GnsbnHBcjrMTFECvdd3NN+7JSPjVDkBe/gwnDUtLF57pZqnfCihPXCOeWnx+uBS7E1
         EbShN8vUKPP+aO1EW+awhIkPo2qx2G3RyiFB2A757huH0jQVyIFhaO8aBZ2HUDKFdh34
         h6D7Cp5LEpTDPbCbDBJzjzDKGz746kkCZwhuRLQtszazYjKrGDqhWQtc4DAUHY93+Wku
         +jW08whZs4tspJIvrFhT6QpyJJ5yFU956DXhVrWrTfITi3N2eP6fjFFt+VGwUBVgqYvO
         oaAPRjf+oAT3u5G/T43r7N4s7tQloZDPk0mAj5dMciB4QXc8Ox6n79rAZ035pWTXvPlJ
         MJeQ==;
        darn=lists.linux.dev
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789053871; x=1789658671; darn=lists.linux.dev;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=W02XYVTB0Nl5fojAG5hBMBTOksfDYePfH5xC6TePd8A=;
        b=iyZfODGGSBtq9XwGJ0s5ukmToA/aqZIHZRnaQVGlsjmpDZHuoyRPAxLxq4qcKGJOCK
         e71w06LBwgJ8cuzuMiHeXbU4WdzdUen73I0fnNr3pJIs0DdrsnUEHuQ6BH3N1vhr9u+c
         OKEvM5cqMhTtnr9IYLIl38jGZ28EboMqDq6H/AMyLUrQbBL0Nsq6oKTrIOnviIGV8Q7C
         Rd64SPbsGCskVY3CcsT5+juoPeHTB8qoT6/ZvkedqjSb2vwESNNxBx9PQv6A482ez8oq
         KtbyIP9PwSmbYfGLKBmzpWKxW+cWYYBCW9dhdRDfUxpf6h4Nm6tn631QscG18Sl39hEE
         6F1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789053871; x=1789658671;
        h=content-transfer-encoding:content-type:cc:to:subject:message-id
         :date:from:in-reply-to:references:mime-version:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=W02XYVTB0Nl5fojAG5hBMBTOksfDYePfH5xC6TePd8A=;
        b=BvGsaqXF468rg2E1Y2whR1Wyvu8AK7rVkP8VWCiQcJrLycK3uD5Uq520An+pIS2woD
         2CRRx/FYGIO82iUJTmfTTmFr+gjo2BxA5fPfmRn1225OgoYp/teWK9xRgCLmxwu1IrGy
         T7vTbu3Jb9TZRpego9ZQHSY9Zu5j6JgfwhW60xV7XGSTN9nMhreuTMxo5Bd3Ru4e4Eag
         hP4zlp/TjkXoInu9ivQouDGPtNMcF6vS3fSuP/DObNJKKDnu9KDfVQ31fPL+LFhc5wpN
         pW2UqJkqj1KNlnlvvT69Jk8mAofF0nUpWv8SX3hfH95HAv7PtAHPfSBRIKFT1dAzllDb
         ADUw==
X-Forwarded-Encrypted: i=1; AKwUvBxhJoWogOYX1zO0lCyjgGFKZT1Z/yXkdk+sByMhkWAzuDQJNCdBdwiyhTBM3as5qi5jGWpi@lists.linux.dev
X-Gm-Message-State: AFuF++mYGZRGZizFW+pdozNetCpX92BIrKHP0b4aXi1qtpMfuw/3LmB3
	1PbO6IfQ1snI1i+V6Ly81H2dKs3rF0xHSO5CEo3GRwFxDMz8KjzjrS/TdX1zsG9rSm1vs9XeWdf
	WZpRY4ZJcCr5p50nOuvD0G8VdzphCq9c=
X-Gm-Gg: AYBFou0yMjDfCC+u47hk3D6MshXrvJ4PreXSxni/qEYU2Vdugel1n1JZWOIePW7dcwA
	XkVP/sIsQWVIulLk1cjs056ijQiV4qrKOg9EQQzGzTGG7Gvv8pLgoqadvyGifn1OQiOoXtP3fH4
	Sn8TQ+EZfcjH1nq6SmTpiD/BaMfpC4nNILihmU4aKHipf7ENcBAJiRgU99lTG2JgLRCmCeDWBz9
	nwKRTPUDY8oLeKOy1L/jIWCRrm5jLjQbDkgxH8IOcakCUpk3BHanRz0jOxiKhVlzwXc1tgv5Wcj
	xG7X5tuCGLCkzD4kV0BzYTkkf9YzkW+7p2SJdmhsCIOpGpQeUVB4aIo=
X-Received: by 2002:a05:6402:3512:b0:6a8:451:32b4 with SMTP id
 4fb4d7f45d1cf-6a99ccf0837mr3371397a12.23.1789053870395; Thu, 10 Sep 2026
 08:24:30 -0700 (PDT)
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
References: <9CC2EE8A-9F67-408A-87A1-62AF671B4BFB@linux.ibm.com> <20260910141524.12362-1-spasswolf@web.de>
In-Reply-To: <20260910141524.12362-1-spasswolf@web.de>
From: Chris S <coshi036@gmail.com>
Date: Thu, 10 Sep 2026 11:24:19 -0400
X-Gm-Features: AcwNN1XO9GRsWlKpqFSX7PpQbLAxVz7EBaLMtD1MZCmQjL9KwHLULMUzhoKDyzc
Message-ID: <CACd_6n2cPqmqs=Ao6yKGSzW8WxUPPsHaLJBOHGeMtKPkk6aR_Q@mail.gmail.com>
Subject: Re: [PATCH v2 03/21] jbd2: point the shadow buffer at the frozen data directly
To: Bert Karwatzki <spasswolf@web.de>
Cc: Joseph Qi <jiangqi903@gmail.com>, Jan Kara <jack@suse.cz>, Venkat <venkat88@linux.ibm.com>, 
	Alexander Viro <viro@zeniv.linux.org.uk>, Matthew Wilcox <willy@infradead.org>, 
	linux-fsdevel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>, 
	Andreas Dilger <adilger.kernel@dilger.ca>, Baokun Li <libaokun@linux.alibaba.com>, 
	Ojaswin Mujoo <ojaswin@linux.ibm.com>, Ritesh Harjani <ritesh.list@gmail.com>, 
	Zhang Yi <yi.zhang@huawei.com>, Zhang Yi <yi.zhang@huaweicloud.com>, 
	Bob Copeland <me@bobcopeland.com>, Namjae Jeon <linkinjeon@kernel.org>, 
	Sungjong Seo <sj1557.seo@samsung.com>, Yuezhang Mo <yuezhang.mo@sony.com>, 
	OGAWA Hirofumi <hirofumi@mail.parknet.co.jp>, Mark Fasheh <mark@fasheh.com>, 
	Joel Becker <jlbec@evilplan.org>, Joseph Qi <joseph.qi@linux.alibaba.com>, 
	Andreas Gruenbacher <agruenba@redhat.com>, linux-ext4@vger.kernel.org, 
	ocfs2-devel@lists.linux.dev, gfs2@lists.linux.dev, 
	linux-kernel@vger.kernel.org, linux-next@vger.kernel.org, 
	Weidong Zhu <weizhu@fiu.edu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

You are right - I checked rather than taking my own word for it,
next-20260909 still has the unguarded dereference.

The fix is in, just not where linux-next takes its vfs branch from yet.
Christian folded the b_folio check into the commit that introduces the
folio-less buffer rather than carrying a separate patch, so on vfs.git's
vfs-7.4.bh branch 781bf9c7e307 ("buffer: allow a buffer_head to point at
memory outside the page cache") now reads

if (bh->b_folio && folio_test_dropbehind(bh->b_folio) &&
   op_is_write(opf))

That finished this morning.  linux-next merges vfs.all with tip is still
2026-09-02, so it carries the series without the fix - which is exactly
what you are hitting.  Should go away once vfs.all is regenerated.

Thanks,
Chao

On Thu, Sep 10, 2026 at 10:16=E2=80=AFAM Bert Karwatzki <spasswolf@web.de> =
wrote:
>
> Just a quick reminder, in linux next-20260909 this has not been
> fixed, yet.
>
> Bert Karwatzki
