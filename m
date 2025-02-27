Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9829D22B5B5
	for <gfs2@lists.linux.dev>; Thu, 27 Feb 2025 12:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740658832; cv=none; b=ktlgxkJz3ZFSkZoawIMZ9MzVaa7fEPty8n8n1MkuERaTgE7YOw9QsvpHej5D/SAwnfY6TMNCuqV8KIBnEexGB8oVfE/bzOHWpaRsx05wmCAa7PB79/GFj3HlGLiBBfxVOtEnWQQz4B1+YLJHD4gobbrQ1+XJ+32rOjED3cI95IQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740658832; c=relaxed/simple;
	bh=q078y0Enc2o+dxlEFaiZkgldRVKGjWQizuuEC8CdaBU=;
	h=Message-ID:Date:MIME-Version:To:From:Subject:Content-Type; b=RwirQKWGwf+mkvgLUnSJDLTpJZ355Xhuch7QsFSlU36ub7yjAnf7kvhfVRZo1O4z+F62QJ5+6dnth/eKm9Ky7P3zVDH7YqsA+QxXfQXKPKslu5FoKz9zbW/TQ+ZprSCVotDAD9hprGyHzP+3+FrCBr8gECuhIDWp/cHEPPSH1to=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=hYSDXCpr; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hYSDXCpr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1740658829;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=fkTj4jtfOIADd/DtVrs48A3D4mlxdMBfjqu10PeqbSs=;
	b=hYSDXCprAt/FPybrb/iG3zAcFuLbSzTVDITkS9nqv5Mf+sUNXgMkLPJPE7AJm3+RPiv+Wx
	8RoifQ5NMoTD3BbNabBIeqfK+13Gy/NNrvDwObVtQxh43jjQBr9qK9QCWOUxIuZ6CXscDU
	DfnYvH2p2dyCb2yBI3pOw5O7Ty+adKQ=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-GSh9g5dfNiqxv8Mp6z3PpQ-1; Thu, 27 Feb 2025 07:20:27 -0500
X-MC-Unique: GSh9g5dfNiqxv8Mp6z3PpQ-1
X-Mimecast-MFC-AGG-ID: GSh9g5dfNiqxv8Mp6z3PpQ_1740658827
Received: by mail-wr1-f72.google.com with SMTP id ffacd0b85a97d-390de58dc4eso831295f8f.0
        for <gfs2@lists.linux.dev>; Thu, 27 Feb 2025 04:20:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1740658826; x=1741263626;
        h=content-transfer-encoding:subject:from:to:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fkTj4jtfOIADd/DtVrs48A3D4mlxdMBfjqu10PeqbSs=;
        b=a6KAtuj81iwpqC0VgEZefdqmG/zUOgqeXTQGfz/guESRsJ4dsOQi42Dt7FXs8gzBRN
         a0dowWF2jerAMO99wdPG6q9IwmTRyOUuiwevX7tY0wrswu7mkDebseWZMO0Kuh6LuR4Z
         aIxkttnXO6pTZpi4NbXvuD9eXO5yL/p8T3qo7ss1FAIgwsa1TElsXFgI6ZteTpFAFK7j
         dYBvuSod9kVDEcKj1Sj+0ivkyrwOAGPnOn87sLf7FFqMrii1/acEPa9AQKdooyFau5rQ
         495QmvPEJIo4VstJDdPCSSSQ6qhdo1cbPaN5pquc/dKHty2I0be8N7RRXuFNRk7mQPlw
         hJSw==
X-Gm-Message-State: AOJu0Yxd5ySAioT2fKPUwhMOEoiILY6hVJyhLMWArRBSwi6l5rK2awaS
	SzSHFD29gcRXi7VBjddiLyPxdXLU3VxTam+vAJQUwusrvLHf8SPkymYV24fRTEM1Z7kY+YxZ59B
	YYjc6HXeuPdQLsUKcDQOrCWu0Srmuu2iE15O3I65zBkrp9wTw7kh7nrbBHoCtDgBjHNC/HA/aBh
	4aS0MUstmusTgXyPNRe/g0pLCRE81Rve0jrg==
X-Gm-Gg: ASbGncs+HHwiiFuH7dwIueDSWfdPRv4w2lGJPwgiRqv7GZUeVU3aLpWmx1o3NIkyyNq
	V+qZGVCJbv5Sl2b/4EJmJG9NBBZaCfKieeIi7XqDKSPQFc/XZKshRc7iDDcHCW5Z25TBrNBOFdW
	4V4gezMYtAb7fVYE1se/kFaHV13TzEXM5vw+s/FomFn/VuxV9r28xYIlGMDB8QrFvVN9+ws5tqg
	vVrPFarTnkeJix7+1SsRSxT/PCVwIeGjJteh1jSplHUWCoHer8yFS5r1v/hPBkKW0Zv9wvlBbdO
	qwxKDs2+Hax81qa8vTAP7GEdku7hHDrHtzMveMhl/Zjrxq11fIZ01BWjGhh/KGfOuoTU0aIDNvs
	=
X-Received: by 2002:a5d:5f53:0:b0:38e:d026:820 with SMTP id ffacd0b85a97d-390cc6042f9mr14082895f8f.16.1740658826644;
        Thu, 27 Feb 2025 04:20:26 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGV0slAi0NtK3HXoQU3paoz9UvvWmsUeUxFVFQjWJ9w3LV2bCQIlTAOEkwXRmARQPDDPRsuDQ==
X-Received: by 2002:a5d:5f53:0:b0:38e:d026:820 with SMTP id ffacd0b85a97d-390cc6042f9mr14082854f8f.16.1740658826233;
        Thu, 27 Feb 2025 04:20:26 -0800 (PST)
Received: from [192.168.1.167] (cpc76484-cwma10-2-0-cust967.7-3.cable.virginm.net. [82.31.203.200])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-390e47b7a73sm1904579f8f.50.2025.02.27.04.20.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Feb 2025 04:20:25 -0800 (PST)
Message-ID: <b4be3783-5cc6-499f-b591-2acd2ab3c761@redhat.com>
Date: Thu, 27 Feb 2025 12:20:25 +0000
Precedence: bulk
X-Mailing-List: gfs2@lists.linux.dev
List-Id: <gfs2.lists.linux.dev>
List-Subscribe: <mailto:gfs2+subscribe@lists.linux.dev>
List-Unsubscribe: <mailto:gfs2+unsubscribe@lists.linux.dev>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
To: gfs2@lists.linux.dev, users@clusterlabs.org, developers@clusterlabs.org
From: Andrew Price <anprice@redhat.com>
Subject: gfs2-utils 3.6.1 released
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: yVQpz9C3qlX7P0ffTz5VcOm7YTyhdzn8p7oeAICELws_1740658827
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

gfs2-utils contains the tools needed to create, check, modify and 
inspect gfs2 filesystems along with support scripts needed on every gfs2 
cluster node.

This point release is mainly to provide fixed tarballs after two of the 
3.6.0 tarballs were uploaded uncompressed. It contains only two minor 
documentation changes.

The full git shortlog is below.

The release tarballs and signed checksums can be found here:

https://releases.pagure.org/gfs2-utils/

A direct link for this release:

https://releases.pagure.org/gfs2-utils/gfs2-utils-3.6.1.tar.gz

Please report bugs to the gfs2@lists.linux.dev mailing list or at:

https://bugzilla.kernel.org/enter_bug.cgi?product=File%20System&component=gfs2

Patches or pull requests can be sent to the same list or submitted on 
Pagure:

https://pagure.io/gfs2-utils

Thanks,
Andy

gfs2-utils changes since 3.6.0:

Andrew Price (3):
       Update version for development
       DeveloperIntro.md: Update git archive options and config
       Prepare for version 3.6.1

Valentin Vidic (1):
       gfs2_edit.8: Fix man page warning

